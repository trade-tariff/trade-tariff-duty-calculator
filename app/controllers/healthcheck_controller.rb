class HealthcheckController < ApplicationController
  def ping
    render status: :ok, body: 'PONG'
  end
end
