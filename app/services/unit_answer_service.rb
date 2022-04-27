class UnitAnswerService
  def initialize(unit, applicable_units)
    @unit = unit
    @applicable_units = applicable_units
  end

  def call
    coerced_measurement_unit_code = @unit['coerced_measurement_unit_code']

    if coerced_measurement_unit_code.present?
      # We deduplicate coerced units so we're only asking unit questions once.
      #
      # For example DTN, DTNE and DTNR are all input as KGM (kilograms) and coerced back into their original unit
      # and rather than answering the same question 3 times we dedupe and fetch the unit that has the corresponding
      # input answer on the session for our current unit.
      answer_unit = @applicable_units.find do |measurement_unit_code, measure_unit_values|
        has_coerced_code = measure_unit_values['coerced_measurement_unit_code'] == coerced_measurement_unit_code
        has_coerced_input_answer = user_session.measure_amount[measurement_unit_code.downcase].present?

        # In the non-coerced case, we're handling the situation where, say, KGM is an uncoerced unit in itself but
        # is also the answer key we've stored against on the user session.
        has_non_coerced_input_answer = user_session.measure_amount[coerced_measurement_unit_code.downcase].present? &&
          measurement_unit_code == coerced_measurement_unit_code

        has_non_coerced_input_answer || has_coerced_code && has_coerced_input_answer
      end

      return nil if answer_unit.blank?

      user_session.measure_amount[answer_unit[0].downcase]
    else
      user_session.measure_amount["#{@unit['measurement_unit_code']}#{@unit['measurement_unit_qualifier_code']}".downcase]
    end
  end

  private

  def user_session
    UserSession.get
  end
end
