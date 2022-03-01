module Api
  class Commodity < Api::Base
    has_many :import_measures, Measure
    has_many :export_measures, Measure

    meta_attribute :duty_calculator, :applicable_measure_units
    meta_attribute :duty_calculator, :applicable_additional_codes
    meta_attribute :duty_calculator, :applicable_vat_options
    meta_attribute :duty_calculator, :trade_defence
    meta_attribute :duty_calculator, :zero_mfn_duty
    meta_attribute :duty_calculator, :source

    attributes :id,
               :producline_suffix,
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

    alias_method :meursing_code?, :meursing_code

    def description
      attributes[:description].html_safe
    end

    def code
      goods_nomenclature_item_id
    end

    def rules_of_origin_schemes
      RulesOfOriginScheme.build_collection(
        user_session.import_destination.downcase.to_sym,
        nil,
        heading_code: goods_nomenclature_item_id.first(6),
        country_code: user_session.country_of_origin,
      )
    end

    def formatted_commodity_code(additional_code = nil)
      formatted_code = "#{code[0..3]} #{code[4..5]} #{code[6..7]} #{code[8..9]}"
      return formatted_code if additional_code.blank?

      "#{formatted_code} (#{additional_code})".html_safe
    end

    def applicable_measures
      @applicable_measures ||= no_additional_code_measures + additional_code_measures
    end

    def applicable_excise_measure_units
      applicable_measure_units.select do |unit, _value|
        unit.in?(excise_measure_units)
      end
    end

    def applicable_excise_measures
      @applicable_excise_measures ||= applicable_measures.select(&:excise)
    end

    private

    def excise_measure_units
      @excise_measure_units ||= excise_measures.flat_map(&:all_units).uniq
    end

    def excise_measures
      @excise_measures ||= import_measures.select(&:excise)
    end

    def no_additional_code_measures
      non_vat_import_measures.reject(&:additional_code)
    end

    def additional_code_measures
      non_vat_import_measures.select do |measure|
        measure_additional_code = measure.additional_code&.formatted_code
        user_additional_code_answer = user_session.additional_code_for(measure.measure_type, source)

        next if measure_additional_code.nil?

        user_additional_code_answer == measure_additional_code
      end
    end

    def non_vat_import_measures
      import_measures.reject(&:vat)
    end
  end
end
