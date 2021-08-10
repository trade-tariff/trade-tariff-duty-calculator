module Steps
  class ExciseController < BaseController
    def show
      @step = Steps::Excise.new(permitted_params)
    end

    def create
      @step = Steps::Excise.new(permitted_params)

      validate(@step)
    end

    private

    def permitted_params
      return params.permit(:measure_type_id) if params[:steps_excise].blank?

      params.require(:steps_excise).permit(
        :additional_code,
      ).merge(params.permit(:measure_type_id))
    end
  end
end
