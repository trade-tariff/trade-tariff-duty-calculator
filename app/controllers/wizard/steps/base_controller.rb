module Wizard
  module Steps
    class BaseController < ::ApplicationController
      default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder
      after_action :track_session

      helper_method :commodity,
                    :commodity_code,
                    :commodity_source,
                    :user_session,
                    :country_of_origin_description

      def commodity
        @commodity ||= Api::Commodity.build(
          commodity_source,
          commodity_code,
        )
      end

      def filtered_commodity(filter: default_filter)
        Api::Commodity.build(
          commodity_source,
          commodity_code,
          filter,
        )
      end

      def user_session
        @user_session ||= UserSession.new(session)
      end

      def country_of_origin_description
        Api::GeographicalArea.find(
          user_session.country_of_origin,
          user_session.import_destination.downcase.to_sym,
        ).description
      end

      protected

      def validate(step)
        if step.valid?
          step.save

          redirect_to step.next_step_path
        else
          render 'show'
        end
      end

      def commodity_code
        params[:commodity_code] || user_session.commodity_code
      end

      def commodity_source
        params[:referred_service] || user_session.commodity_source
      end

      def default_filter
        { 'filter[geographical_area_id]' => user_session.country_of_origin }
      end

      def track_session
        ::NewRelic::Agent.add_custom_attributes({
          session: user_session.session.to_h.except('_csrf_token'),
          commodity_code: user_session.commodity_code,
          commodity_source: user_session.commodity_source,
          referred_service: user_session.referred_service,
        })
      end
    end
  end
end
