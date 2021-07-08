module Steps
  class ConfirmationController < BaseController
    def show
      @step = Steps::Confirmation.new(user_session)

      @decorated_step = ::ConfirmationDecorator.new(@step, filtered_commodity)
    end
  end
end
