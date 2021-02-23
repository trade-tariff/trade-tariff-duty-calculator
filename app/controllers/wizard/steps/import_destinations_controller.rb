module Wizard
  module Steps
    class ImportDestinationsController < BaseController
      def show
        @step = Wizard::Steps::ImportDestination.new(user_session)
      end

      def create
        @step = Wizard::Steps::ImportDestination.new(user_session, permitted_params)

        if @step.valid?
          @step.save

          redirect_to country_of_origin_path
        else
          render 'show'
        end
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
