class HomeController < ApplicationController
  def question_1
    redirect_to question_2_path
  end

  def question_2
  end
end
