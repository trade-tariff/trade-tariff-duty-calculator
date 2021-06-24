module DutyOptions
  class Base
    include ActionView::Helpers::NumberHelper
    include ServiceHelper

    def initialize(measure, user_session, additional_duty_options)
      @measure = measure
      @user_session = user_session
      @additional_duty_options = additional_duty_options
    end

    def option
      {
        footnote: localised_footnote,
        warning_text: nil,
        values: option_values,
        value: value,
      }
    end

    def self.id
      name.split('::').last.underscore
    end

    protected

    attr_reader :measure, :user_session, :additional_duty_options

    def option_values
      table = [valuation_row]
      table += measure_rows
      table += additional_duty_rows
      table << duty_totals_row
      table
    end

    def measure_rows
      presented_rows = []
      presented_rows << measure_unit_row if measure_unit?
      presented_rows << duty_calculation_row
    end

    def duty_calculation_row
      presented_rows = []
      presented_rows << I18n.t(
        'duty_calculations.options.import_duty_html',
        commodity_source: presented_commodity_source,
        option_type: option_type,
        additional_code: formatted_additional_code,
      ).html_safe
      presented_rows.concat(duty_evaluation.slice(:calculation, :formatted_value).values)
    end

    def measure_unit_row
      [I18n.t('duty_calculations.options.import_quantity'), nil, "#{total_quantity} #{unit}"]
    end

    def measure_unit?
      unit.present?
    end

    def total_quantity
      duty_evaluation[:total_quantity]
    end

    def unit
      duty_evaluation[:unit]
    end

    def value
      duty_evaluation[:value]
    end

    def valuation_row
      [
        I18n.t('duty_calculations.options.import_valuation'),
        I18n.t('duty_calculations.options.customs_value'),
        number_to_currency(user_session.total_amount),
      ]
    end

    def duty_totals_row
      [
        I18n.t('duty_calculations.options.duty_total_html').html_safe,
        nil,
        "<strong>#{number_to_currency(duty_totals)}</strong>".html_safe,
      ]
    end

    def duty_evaluation
      @duty_evaluation ||= measure.evaluator_for(user_session).call
    end

    def duty_totals
      duty_values = [duty_evaluation[:value]]

      (additional_duty_values + duty_values).inject(:+)
    end

    def option_type
      I18n.t("duty_calculations.options.option_type.#{self.class.id}")
    end

    def additional_duty_rows
      additional_duty_options.map { |option| option[:values].flatten }
    end

    def additional_duty_values
      additional_duty_options.map { |additional_duty| additional_duty[:value] }
    end

    def base_localised_footnote
      return I18n.t("measure_type_footnotes.#{measure.measure_type.id}").html_safe unless measure.measure_type.additional_option?

      I18n.t("measure_type_footnotes.#{measure.measure_type.id}", link: link).html_safe
    end

    def localised_footnote
      return base_localised_footnote unless user_session.row_to_ni_route?

      base_localised_footnote.concat(I18n.t("row_to_ni_route.#{measure.source}.footnote").html_safe)
    end

    def link
      "#{trade_tariff_frontend_url}/#{relative_path}"
    end

    def relative_path
      "#{user_session.commodity_source}/commodities/#{user_session.commodity_code}?country=#{user_session.country_of_origin}#import"
    end

    def formatted_additional_code
      " (#{additional_code})".html_safe if additional_code
    end

    def additional_code
      measure.additional_code&.code
    end

    def presented_commodity_source
      measure.source == 'xi' ? 'EU' : 'UK'
    end
  end
end
