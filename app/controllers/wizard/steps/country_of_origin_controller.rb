module Wizard
  module Steps
    class CountryOfOriginController < BaseController
      def show
        @step = Wizard::Steps::CountryOfOrigin.new(user_session)
      end

      def create
        @step = Wizard::Steps::CountryOfOrigin.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_country_of_origin).permit(
          :country_of_origin,
        )
      end
    end
  end
end
