class HealthcheckController < ApplicationController
  def checkz
    render json: { git_sha1: CURRENT_REVISION }
  end

  def healthcheck
    render status: :ok, json: { git_sha1: CURRENT_REVISION }
  end
end
