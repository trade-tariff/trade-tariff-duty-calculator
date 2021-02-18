module Wizard
  module Steps
    class CountryOfOriginController < BaseController
      def show
        @country = Wizard::Steps::CountryOfOrigin.new(session)
      end

      def create
        @country = Wizard::Steps::CountryOfOrigin.new(session, permitted_params)

        if @country.valid?
          @country.save
        else
          render 'show'
        end
      end

      private

      def permitted_params
        params.require(:wizard_steps_country_of_origin).permit(
          :geographical_area_id,
        )
      end
    end
  end
end
