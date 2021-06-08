module Wizard
  module Steps
    class VatController < BaseController
      def show
        @step = Wizard::Steps::Vat.new(user_session)
      end

      def create
        @step = Wizard::Steps::Vat.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_vat).permit(
          :vat,
        )
      end
    end
  end
end
