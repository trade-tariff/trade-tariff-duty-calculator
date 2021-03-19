module Wizard
  module Steps
    class ImportDateController < BaseController
      def show
        @step = Wizard::Steps::ImportDate.new(user_session)

        user_session.commodity_code = commodity_code

        if params[:referred_service].present?
          user_session.referred_service = params[:referred_service]
          user_session.commodity_source = params[:referred_service]
        end
      end

      def create
        @step = Wizard::Steps::ImportDate.new(user_session, permitted_params)

        validate(@step)
      end

    private

      def permitted_params
        params.require(:wizard_steps_import_date).permit(
          :'import_date(3i)',
          :'import_date(2i)',
          :'import_date(1i)',
        )
      end
    end
  end
end
