module Steps
  class CustomsValueController < BaseController
    def show
      @step = Steps::CustomsValue.new(user_session)
    end

    def create
      @step = Steps::CustomsValue.new(user_session, permitted_params)

      validate(@step)
    end

    private

    def permitted_params
      params.require(:steps_customs_value).permit(
        :monetary_value,
        :shipping_cost,
        :insurance_cost,
      )
    end
  end
end
