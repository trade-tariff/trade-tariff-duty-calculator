module Steps
  class ExciseController < BaseController
    def show
      @step = Steps::Excise.new(user_session, measure_type_id)
    end

    def create
      @step = Steps::Excise.new(user_session, permitted_params)

      validate(@step)
    end

    private

    def permitted_params
      params.require(:steps_excise).permit(
        :additional_code,
      ).merge(measure_type_id)
    end

    def measure_type_id
      params.permit(:measure_type_id)
    end
  end
end
