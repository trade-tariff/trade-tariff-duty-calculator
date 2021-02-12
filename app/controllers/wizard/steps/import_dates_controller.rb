module Wizard
  module Steps
    class ImportDatesController < BaseController
      def show
        @import_date = Wizard::Steps::ImportDate.new(session)
      end

      def create
        @import_date = Wizard::Steps::ImportDate.new(session, permitted_params)

        if @import_date.valid?
          @import_date.save

          redirect_to "/duty-calculator/#{params[:commodity_code]}/import-destination"
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
