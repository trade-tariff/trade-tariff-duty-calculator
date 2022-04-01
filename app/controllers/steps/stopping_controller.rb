module Steps
  class StoppingController < BaseController
    def show
      @step = Steps::Stopping.new
    end
  end
end
