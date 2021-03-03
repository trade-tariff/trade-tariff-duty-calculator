module Wizard
  module Steps
    class FinalUseController < BaseController
      def show
        @step = Wizard::Steps::FinalUse.new(user_session)
      end

      def create
        @step = Wizard::Steps::FinalUse.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_final_use).permit(
          :final_use,
        )
      end
    end
  end
end
