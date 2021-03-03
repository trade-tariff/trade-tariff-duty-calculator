module Wizard
  module Steps
    class TraderSchemeController < BaseController
      def show
        @step = Wizard::Steps::TraderScheme.new(user_session)
      end

      def create
        @step = Wizard::Steps::TraderScheme.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_trader_scheme).permit(
          :trader_scheme,
        )
      end
    end
  end
end
