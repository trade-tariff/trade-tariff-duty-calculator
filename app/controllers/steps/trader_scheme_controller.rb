module Steps
  class TraderSchemeController < BaseController
    def show
      @step = Steps::TraderScheme.new
    end

    def create
      @step = Steps::TraderScheme.new(permitted_params)

      validate(@step)
    end

    private

    def permitted_params
      params.require(:steps_trader_scheme).permit(
        :trader_scheme,
      )
    end
  end
end
