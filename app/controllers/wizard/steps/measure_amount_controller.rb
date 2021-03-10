module Wizard
  module Steps
    class MeasureAmountController < BaseController
      def show
        @step = Wizard::Steps::MeasureAmount.new(
          user_session, measure_amount: {}, applicable_measure_units: applicable_measure_units
        )
      end

      def create
        @step = Wizard::Steps::MeasureAmount.new(user_session, measure_amount_params)

        validate(@step)
      end

      private

      def measure_amount_params
        measure_amount_answers = if params.key?(:wizard_steps_measure_amount)
                                   params.require(:wizard_steps_measure_amount).permit(*applicable_measure_unit_keys)
                                 else
                                   {}
                                 end

        {
          'measure_amount' => measure_amount_answers,
          'applicable_measure_units' => applicable_measure_units,
        }
      end

      def applicable_measure_unit_keys
        applicable_measure_units.keys.map(&:downcase)
      end

      def applicable_measure_units
        commodity.applicable_measure_units
      end
    end
  end
end
