module MeasureUnitPresentable
  extend ActiveSupport::Concern

  def presented_unit
    @presented_unit ||= {
      answer: user_session.measure_amount[component.unit.downcase.to_s],
      unit: applicable_unit['unit'],
    }
  end

  def applicable_unit
    applicable_units[component.unit]
  end

  private

  def applicable_units
    ApplicableMeasureUnitMerger.new.call
  end
end
