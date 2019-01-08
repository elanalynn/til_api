class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  skip_before_filter :verify_authenticity_token

  attr_reader :current_user

  private

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
