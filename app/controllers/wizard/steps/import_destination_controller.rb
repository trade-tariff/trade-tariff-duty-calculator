module Wizard
  module Steps
    class ImportDestinationController < BaseController
      def show
        @step = Wizard::Steps::ImportDestination.new(user_session)
      end

      def create
        @step = Wizard::Steps::ImportDestination.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_import_destination).permit(
          :import_destination,
        )
      end
    end
  end
end
