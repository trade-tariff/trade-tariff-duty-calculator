module Wizard
  module Steps
    class BaseController < ::ApplicationController
      default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

      helper_method :commodity

      def commodity
        @commodity ||= Api::Commodity.build(
          service_choice,
          commodity_code,
        )
      end

      def filtered_commodity(service_source:, filter:)
        Api::Commodity.build(
          service_source,
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

          redirect_to step.next_step_path(
            service_choice: params[:service_choice],
            commodity_code: params[:commodity_code],
          )
        else
          render 'show'
        end
      end

      def commodity_code
        params[:commodity_code]
      end

      def service_choice
        params[:service_choice].to_sym
      end
    end
  end
end
