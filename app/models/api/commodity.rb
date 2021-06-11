module Api
  class Commodity < Api::Base
    has_many :import_measures, Measure
    has_many :export_measures, Measure

    meta_attribute :duty_calculator, :applicable_measure_units
    meta_attribute :duty_calculator, :applicable_additional_codes
    meta_attribute :duty_calculator, :applicable_vat_options
    meta_attribute :duty_calculator, :trade_defence
    meta_attribute :duty_calculator, :zero_mfn_duty

    attributes :producline_suffix,
               :number_indents,
               :description,
               :goods_nomenclature_item_id,
               :bti_url,
               :formatted_description,
               :description_plain,
               :consigned,
               :consigned_from,
               :basic_duty_rate,
               :meursing_code,
               :declarable,
               :footnotes,
               :section,
               :chapter,
               :heading,
               :ancestors

    def description
      super.html_safe
    end

    def code
      goods_nomenclature_item_id
    end

    def formatted_commodity_code(additional_code = nil)
      formatted_code = "#{code[0..3]} #{code[4..5]} #{code[6..7]} #{code[8..9]}"
      return formatted_code if additional_code.blank?

      "#{formatted_code} (#{additional_code})".html_safe
    end
  end
end
