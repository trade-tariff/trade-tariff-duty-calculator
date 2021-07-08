module Steps
  class FinalUseController < BaseController
    def show
      @step = Steps::FinalUse.new(user_session)
    end

    def create
      @step = Steps::FinalUse.new(user_session, permitted_params)

      validate(@step)
    end

    private

    def permitted_params
      params.require(:steps_final_use).permit(
        :final_use,
      )
    end
  end
end
