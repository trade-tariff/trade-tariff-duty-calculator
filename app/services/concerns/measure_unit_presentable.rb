module MeasureUnitPresentable
  extend ActiveSupport::Concern

  def presented_unit
    @presented_unit ||= {
      answer: unit_answer_for(applicable_unit),
      unit: applicable_unit['unit'],
      multiplier: applicable_unit['multiplier'].presence || 1,
    }
  end

  def applicable_unit
    applicable_units[component.unit]
  end

  def unit_answer_for(unit)
    UnitAnswerService.new(unit, applicable_units).call
  end

  private

  def applicable_units
    @applicable_units ||= ApplicableMeasureUnitMerger.new(dedupe: false).call
  end
end
