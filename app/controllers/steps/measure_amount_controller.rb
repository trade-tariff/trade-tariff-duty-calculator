module Steps
  class MeasureAmountController < BaseController
    def show
      @step = Steps::MeasureAmount.new(measure_amount_params)
    end

    def create
      @step = Steps::MeasureAmount.new(measure_amount_params)

      validate(@step)
    end

    private

    def measure_amount_params
      {
        'measure_amount' => measure_amount_answers,
        'applicable_measure_units' => applicable_measure_units,
      }
    end

    def measure_amount_answers
      return {} unless params.key?(:steps_measure_amount)

      params.require(:steps_measure_amount).permit(*applicable_measure_unit_keys).to_h
    end
  end
end
