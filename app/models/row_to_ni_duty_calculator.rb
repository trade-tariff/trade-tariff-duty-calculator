class RowToNiDutyCalculator
  include CommodityHelper

  def initialize(user_session, uk_options, xi_options)
    @user_session = user_session
    @uk_options = uk_options
    @xi_options = xi_options
  end

  def options
    options = uk_options.each_with_object(default_options) do |uk_option, acc|
      option = case uk_option[:key]
               when DutyOptions::ThirdCountryTariff.id
                 DutyOptions::Chooser.new(
                   uk_option,
                   xi_options.third_country_tariff_option,
                   user_session.total_amount,
                 ).option
               when DutyOptions::TariffPreference.id
                 option = DutyOptions::Chooser.new(
                   uk_option,
                   xi_options.cheapest_tariff_preference_option || xi_options.third_country_tariff_option,
                   user_session.total_amount,
                 ).option

                 uk_only = xi_options.cheapest_tariff_preference_option.nil?

                 footnote_suffix = I18n.t("row_to_ni_measure_type_footnotes.#{option[:key]}.uk_only.#{option[:evaluation][:source]}") if uk_only

                 option
               end

      next if option.blank?

      footnote_suffix ||= I18n.t("row_to_ni_measure_type_footnotes.#{option[:key]}.#{option[:evaluation][:source]}").html_safe

      option[:evaluation][:footnote] = option[:evaluation][:footnote].concat(footnote_suffix).html_safe

      acc << option
    end

    options = options.uniq do |option|
      option[:evaluation][:measure_sid]
    end

    options = handle_duplicate_mfn_option(options)

    options.sort_by { |h| h[:priority] }
  end

  private

  attr_reader :user_session, :uk_options, :xi_options

  def default_options
    options = []
    options = default_tariff_preference_options if use_eu_tariff_preference_options?

    OptionCollection.new(options)
  end

  def default_tariff_preference_options
    footnote_suffix = I18n.t('row_to_ni_measure_type_footnotes.tariff_preference.xi_only.xi')

    xi_options.tariff_preference_options.each do |option|
      option[:evaluation][:footnote] = option[:evaluation][:footnote].concat(footnote_suffix).html_safe
    end
  end

  def handle_duplicate_mfn_option(options)
    return options unless options.third_country_tariff_options.size > 1

    uk_option = options.third_country_tariff_options.find { |option| option[:evaluation][:source] == 'uk' }
    xi_option = options.third_country_tariff_options.find { |option| option[:evaluation][:source] == 'xi' }

    option_to_keep = DutyOptions::Chooser.new(uk_option, xi_option, user_session.total_amount).option

    option_to_reject = if option_to_keep == uk_option
                         xi_option
                       else
                         uk_option
                       end

    options.reject { |option| option == option_to_reject }
  end

  def use_eu_tariff_preference_options?
    xi_options.tariff_preference_options.present? && uk_options.tariff_preference_options.blank?
  end
end
