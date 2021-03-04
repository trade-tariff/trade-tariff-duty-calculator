module Wizard
  module Steps
    class CertificateOfOriginController < BaseController
      def show
        @step = Wizard::Steps::CertificateOfOrigin.new(user_session)
      end

      def create
        @step = Wizard::Steps::CertificateOfOrigin.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_certificate_of_origin).permit(
          :certificate_of_origin,
        )
      end
    end
  end
end
