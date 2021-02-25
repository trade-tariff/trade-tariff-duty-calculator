module Api
  class GeographicalArea < Api::Base
    EU = '1013'.freeze
    
    has_many :children_geographical_areas, GeographicalArea

    attributes :id,
               :geographical_area_id,
               :description

    def id
      geographical_area_id
    end

    def name
      description.html_safe
    end

    def european_union?
      geographical_area_id == EU
    end

    def self.list_countries(service)
      build_collection(service, 'Country')
    end

    def self.european_union_members(service = :xi)
      build_collection(service).find(&:european_union?).children_geographical_areas
    end
  end
end
