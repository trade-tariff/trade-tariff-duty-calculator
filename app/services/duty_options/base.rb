module DutyOptions
  class Base
    include ActionView::Helpers::NumberHelper
    include ServiceHelper

    def initialize(measure, user_session, additional_duty_options, vat_measure)
      @measure = measure
      @user_session = user_session
      @additional_duty_options = additional_duty_options
      @vat_measure = vat_measure
    end

    def option
      {
        footnote: localised_footnote,
        warning_text: nil,
        values: option_values,
        value: value,
        measure_sid: measure.id,
        source: measure.source,
        category: self.class::CATEGORY,
      }
    end

    def self.id
      name.split('::').last.underscore
    end

    protected

    attr_reader :measure, :user_session, :additional_duty_options, :vat_measure

    def option_values
      table = [valuation_row]
      table += measure_rows
      table += additional_duty_rows
      table << vat_row if vat_measure.present?
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

    def vat_row
      presented_row = []
      presented_row << I18n.t(
        'duty_calculations.options.vat_duty_html',
        option_type: localised_vat_type,
      ).html_safe

      presented_row.concat(vat_evaluation.slice(:calculation, :formatted_value).values)
    end

    def localised_vat_type
      I18n.t("duty_calculations.options.option_type.vat_type.#{vat_measure.vat_type.downcase}")
    end

    def measure_unit?
      unit.present?
    end

    def total_quantity
      NumberWithHighPrecisionFormatter.new(duty_evaluation[:total_quantity]).call
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
        "<strong>#{number_to_currency(duty_totals_plus_vat)}</strong>".html_safe,
      ]
    end

    def vat_evaluation
      @vat_evaluation ||= ExpressionEvaluators::Vat.new(
        vat_measure,
        vat_measure.component,
        user_session,
        duty_totals,
      ).call
    end

    def duty_evaluation
      @duty_evaluation ||= measure.evaluator_for(user_session).call
    end

    def duty_totals
      duty_values = [duty_evaluation[:value]]

      (additional_duty_values + duty_values).inject(:+)
    end

    def duty_totals_plus_vat
      duty_totals + vat_total
    end

    def vat_total
      return 0 if vat_measure.blank?

      vat_evaluation[:value]
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

    def localised_footnote
      I18n.t("measure_type_footnotes.#{measure.measure_type.id}").html_safe
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

    def uk_filtered_commodity
      filtered_commodity(source: 'uk')
    end
  end
end
