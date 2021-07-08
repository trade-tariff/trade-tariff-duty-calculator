module Steps
  class ImportDestinationController < BaseController
    def show
      @step = Steps::ImportDestination.new(user_session)
    end

    def create
      @step = Steps::ImportDestination.new(user_session, permitted_params)

      validate(@step)
    end

    private

    def permitted_params
      params.require(:steps_import_destination).permit(
        :import_destination,
      )
    end
  end
end
