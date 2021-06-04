class HealthcheckController < ApplicationController
  def ping
    render status: :ok, body: 'PONG'
  end

  def healthcheck
    render status: :ok, body: CURRENT_REVISION
  end
end
