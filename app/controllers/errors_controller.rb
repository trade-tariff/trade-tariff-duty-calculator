class ErrorsController < ApplicationController
  layout 'application'

  helper_method :user_session

  def not_found
    respond_to do |format|
      format.html { render status: :not_found }
      format.json { render json: { error: 'Resource not found' }, status: :not_found }
      format.all { render status: :not_found, body: nil }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html { render status: :internal_server_error }
      format.json { render json: { error: 'Internal server error' }, status: :internal_server_error }
    end
  end

  def unprocessable_entity
    respond_to do |format|
      format.html { render status: :unprocessable_entity }
      format.json { render json: { error: 'Unprocessable entity' }, status: :unprocessable_entity }
    end
  end

  def bad_request
    @skip_news_banner = true

    respond_to do |format|
      format.html { render status: :bad_request }
      format.json { render json: { error: 'Bad request' }, status: :bad_request }
      format.all { render status: :bad_request, plain: 'Bad request' }
    end
  end

  def not_implemented
    @skip_news_banner = true

    respond_to do |format|
      format.html { render status: :bad_request }
      format.json { render json: { error: 'Bad request: Not implemented' }, status: :bad_request }
      format.all { render status: :bad_request, plain: 'Bad request: Not Implemented' }
    end
  end

  def method_not_allowed
    @skip_news_banner = true

    respond_to do |format|
      format.html { render status: :bad_request }
      format.json { render json: { error: 'Bad request: Method not allowed' }, status: :bad_request }
      format.all { render status: :bad_request, plain: 'Bad request' }
    end
  end

  def not_acceptable
    @skip_news_banner = true

    respond_to do |format|
      format.html { render status: :bad_request }
      format.json { render json: { error: 'Bad request: Not acceptable' }, status: :bad_request }
      format.all { render status: :bad_request, plain: 'Bad request' }
    end
  end
end
