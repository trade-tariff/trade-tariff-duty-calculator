class ApplicableExciseMeasureUnitFinder < SimpleDelegator
  def call
    applicable_measure_units.each_with_object({}) do |(unit, value), acc|
      matching_component_ids = value['component_ids'].select do |component_id|
        component_id.in?(excise_component_ids)
      end

      matching_condition_component_ids = value['condition_component_ids'].select do |condition_component_id|
        condition_component_id.in?(excise_condition_component_ids)
      end

      next if matching_component_ids.blank? && matching_condition_component_ids.blank?

      value = value.deep_dup
      value['component_ids'] = matching_component_ids.presence || []
      value['condition_component_ids'] = matching_condition_component_ids.presence || []

      acc[unit] = value
    end
  end

  private

  def excise_component_ids
    @excise_component_ids ||= excise_measures.flat_map(&:component_ids)
  end

  def excise_condition_component_ids
    @excise_condition_component_ids ||= excise_measures.flat_map(&:condition_component_ids)
  end
end
