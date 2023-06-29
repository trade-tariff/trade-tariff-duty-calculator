class ApplicationController < ActionController::Base
  before_action :no_store # Rails method to prevent caching
  before_action :user_session

  protected

  def user_session
    @user_session ||= UserSession.build(session)
  end
end
