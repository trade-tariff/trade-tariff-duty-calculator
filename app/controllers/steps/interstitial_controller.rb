module Steps
  class InterstitialController < BaseController
    def show
      @step = Steps::Interstitial.new(user_session)
    end
  end
end
