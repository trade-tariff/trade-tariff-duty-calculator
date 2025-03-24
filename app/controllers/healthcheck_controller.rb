class HealthcheckController < ApplicationController
  def healthcheck
    render status: :ok, json: { git_sha1: CURRENT_REVISION }
  end
end
