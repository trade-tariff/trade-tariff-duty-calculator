module Wizard
  module Steps
    class BaseController < ::ApplicationController
      default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

      helper_method :commodity, :commodity_code, :commodity_source

      def commodity
        @commodity ||= Api::Commodity.build(
          commodity_source,
          commodity_code,
        )
      end

      def filtered_commodity(commodity_source:, filter:)
        Api::Commodity.build(
          commodity_source,
          commodity_code,
          filter,
        )
      end

      def user_session
        @user_session ||= UserSession.new(session)
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
        (params[:referred_service] || user_session.commodity_source).to_sym
      end
    end
  end
end
