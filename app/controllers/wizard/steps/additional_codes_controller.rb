module Wizard
  module Steps
    class AdditionalCodesController < BaseController
      def show
        @step = Wizard::Steps::AdditionalCode.new(user_session, measure_type_id)
      end

      def create
        @step = Wizard::Steps::AdditionalCode.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_additional_code).permit(
          :additional_code_uk,
          :additional_code_xi,
        ).merge(measure_type_id)
      end

      def measure_type_id
        params.permit(:measure_type_id)
      end
    end
  end
end
