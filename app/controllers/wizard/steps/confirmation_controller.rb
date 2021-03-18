module Wizard
  module Steps
    class ConfirmationController < BaseController
      def show
        @step = Wizard::Steps::Confirmation.new(user_session)
      end
    end
  end
end
