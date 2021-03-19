class ApplicationController < ActionController::Base
  before_action :expires_now
end
