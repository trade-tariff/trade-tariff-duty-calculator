module Wizard
  module Steps
    class TraderSchemeController < BaseController
      def show
        @step = Wizard::Steps::TraderScheme.new(user_session)
      end

      def create
        @step = Wizard::Steps::TraderScheme.new(user_session, permitted_params)

        if @step.valid?
          @step.save

          redirect_to @step.next_step_path(
            service_choice: params[:service_choice],
            commodity_code: params[:commodity_code],
          )
        else
          render 'show'
        end
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
