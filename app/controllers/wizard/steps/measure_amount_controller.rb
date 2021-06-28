module Wizard
  module Steps
    class MeasureAmountController < BaseController
      def show
        @step = Wizard::Steps::MeasureAmount.new(user_session, measure_amount_params)
      end

      def create
        @step = Wizard::Steps::MeasureAmount.new(user_session, measure_amount_params)

        validate(@step)
      end

      private

      def measure_amount_params
        {
          'measure_amount' => measure_amount_answers,
          'applicable_measure_units' => applicable_measure_units,
        }
      end

      def applicable_measure_unit_keys
        applicable_measure_units.keys.map(&:downcase)
      end

      def applicable_measure_units
        return filtered_commodity.applicable_measure_units unless user_session.deltas_applicable?

        applicable_measure_units_for(source: 'uk').merge(applicable_measure_units_for(source: 'xi'))
      end

      def measure_amount_answers
        return {} unless params.key?(:wizard_steps_measure_amount)

        params.require(:wizard_steps_measure_amount).permit(*applicable_measure_unit_keys).to_h
      end

      def applicable_measure_units_for(source:)
        filtered_commodity(source: source).applicable_measure_units
      end
    end
  end
end
