module Wizard
  module Steps
    class TradeRemediesController < BaseController
      def show
        @step = Wizard::Steps::TradeRemedy.new(user_session)
      end
    end
  end
end
