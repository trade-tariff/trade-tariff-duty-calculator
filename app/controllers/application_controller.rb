class ApplicationController < ActionController::Base
  after_action :no_store_cache

  def no_store_cache
    expires_in 0, public: false, stale_while_revalidate: 0, stale_if_error: 0
  end

  protected

  def user_session
    @user_session ||= UserSession.new(session)
  end
end
