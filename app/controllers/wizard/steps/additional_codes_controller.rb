module Wizard
  module Steps
    class AdditionalCodesController < BaseController
      def show
        @step = Wizard::Steps::AdditionalCode.new(user_session)
      end

      def create
        @step = Wizard::Steps::AdditionalCode.new(user_session, permitted_params)

        validate(@step)
      end

      private

      def permitted_params; end
    end
  end
end
