module Wizard
  module Steps
    class CountryOfOriginController < BaseController
      def show
        @step = Wizard::Steps::CountryOfOrigin.new(user_session)
      end

      def create
        @step = Wizard::Steps::CountryOfOrigin.new(user_session, permitted_params, opts)

        validate(@step)
      end

      private

      def permitted_params
        params.require(:wizard_steps_country_of_origin).permit(
          :country_of_origin,
        )
      end

      def opts
        return opts_for_ni_to_gb_route if answer == 'GB' && user_session.import_destination == 'XI'

        {}
      end

      def answer
        permitted_params[:country_of_origin]
      end

      def geographical_area_id_filter
        { 'filter[geographical_area_id]' => answer }
      end

      def opts_for_ni_to_gb_route
        {
          trade_defence: commodity.trade_defence,
          zero_mfn_duty: filtered_commodity(service_source: :xi, filter: geographical_area_id_filter).zero_mfn_duty,
        }
      end
    end
  end
end
