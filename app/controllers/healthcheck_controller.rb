class HealthcheckController < ApplicationController
  def ping
    render status: :ok, body: 'PONG'
  end

  def healthcheck
    render status: :ok, json: { git_sha1: CURRENT_REVISION }
  end
end
