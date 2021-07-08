  module Steps
    class TradeRemediesController < BaseController
      def show
        @step = Steps::TradeRemedy.new(user_session)
      end
    end
  end
