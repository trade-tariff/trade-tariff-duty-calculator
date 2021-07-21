module Steps
  class InterstitialController < BaseController
    def show
      @step = Steps::Interstitial.new
    end
  end
end
