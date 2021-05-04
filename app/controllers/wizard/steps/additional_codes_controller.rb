module Wizard
  module Steps
    class AdditionalCodesController < BaseController
      def show
        @step = Wizard::Steps::AdditionalCode.new(user_session)
      end

      def create
        @step = Wizard::Steps::AdditionalCode.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_additional_code).permit!
      end
    end
  end
end
