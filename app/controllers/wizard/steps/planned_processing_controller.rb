module Wizard
  module Steps
    class PlannedProcessingController < BaseController
      def show
        @step = Wizard::Steps::PlannedProcessing.new(user_session)
      end

      def create
        @step = Wizard::Steps::PlannedProcessing.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_planned_processing).permit(
          :planned_processing,
        )
      end
    end
  end
end
