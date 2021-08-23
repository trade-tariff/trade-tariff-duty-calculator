module MeasureUnitHelper
  def presented_unit
    @presented_unit ||= {
      answer: user_session.measure_amount[component.unit.downcase.to_s],
      unit: applicable_unit['unit'],
    }
  end

  def applicable_unit
    ApplicableMeasureUnitMerger.new.call[component.unit]
  end
end
