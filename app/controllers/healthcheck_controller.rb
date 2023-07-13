class HealthcheckController < ApplicationController
  def checkz
    head :ok
  end

  def healthcheck
    render status: :ok, json: { git_sha1: CURRENT_REVISION }
  end
end
