module Api
  class MeasureConditionComponent < Api::BaseComponent
    def measure_condition_sid
      id.split('-').first
    end

    def belongs_to_measure_condition?
      true
    end
  end
end
