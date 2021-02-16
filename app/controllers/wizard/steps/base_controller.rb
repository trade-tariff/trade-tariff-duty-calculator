module Wizard
  module Steps
    class BaseController < ::ApplicationController
      default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

      before_action :assign_commodity

      def assign_commodity
        @commodity = Commodity.new(code: commodity_code)
      end

      protected

      def commodity_code
        params[:commodity_code]
      end
    end
  end
end
