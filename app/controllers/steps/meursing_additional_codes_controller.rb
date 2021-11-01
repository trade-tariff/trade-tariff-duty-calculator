module Steps
  class MeursingAdditionalCodesController < BaseController
    def show
      @step = Steps::MeursingAdditionalCode.new(meursing_additional_code_params)
    end

    def create
      @step = Steps::MeursingAdditionalCode.new(meursing_additional_code_params)

      validate(@step)
    end

    private

    def meursing_additional_code_params
      if params[:steps_meursing_additional_code].present?
        params.require(:steps_meursing_additional_code).permit(:meursing_additional_code)
      else
        {}
      end
    end
  end
end
