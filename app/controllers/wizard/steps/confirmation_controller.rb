module Wizard
  module Steps
    class ConfirmationController < BaseController
      def show
        step = Wizard::Steps::Confirmation.new(user_session)

        @decorated_step = ::ConfirmationDecorator.new(step, commodity)
      end
    end
  end
end
