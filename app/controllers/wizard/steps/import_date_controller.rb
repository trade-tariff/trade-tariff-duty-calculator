module Wizard
  module Steps
    class ImportDateController < BaseController
      def show
        @step = Wizard::Steps::ImportDate.new(user_session)
      end

      def create
        @step = Wizard::Steps::ImportDate.new(user_session, permitted_params)

        if @step.valid?
          @step.save

          redirect_to @step.next_step_path(
            service_choice: params[:service_choice],
            commodity_code: params[:commodity_code],
          )
        else
          render 'show'
        end
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
