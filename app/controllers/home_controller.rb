class HomeController < ApplicationController
  def index
    @data = Answer.new

    @data.valid?
  end

  def question_1
    redirect_to question_2_path
  end

  def question_2
  end
end
