module Api
  class Commodity < Api::Base
    resource_key :commodity_id

    has_many :import_measures, Measure
    has_many :export_measures, Measure

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
               :ancestors,
               :import_measures,
               :export_measures

    def description
      super.html_safe
    end
  end
end
