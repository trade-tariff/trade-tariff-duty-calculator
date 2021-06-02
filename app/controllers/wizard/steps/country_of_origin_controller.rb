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
        return {} unless params.key?(:wizard_steps_country_of_origin)

        params.require(:wizard_steps_country_of_origin).permit(
          :country_of_origin,
          :other_country_of_origin,
        )
      end

      def opts
        return trade_defence_mfn_opts if %w[GB OTHER].include?(answer) && user_session.import_destination == 'XI'

        {}
      end

      def answer
        permitted_params[:country_of_origin]
      end

      def geographical_area_id_filter
        { 'filter[geographical_area_id]' => answer }
      end

      def trade_defence_mfn_opts
        {
          trade_defence: commodity.trade_defence,
          zero_mfn_duty: filtered_commodity(filter: geographical_area_id_filter).zero_mfn_duty,
        }
      end
    end
  end
end
