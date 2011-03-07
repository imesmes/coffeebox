class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      @username = username
      @password = password
    end
  end

  def teambox_api_call(method,*args)
    httpauth = Teambox::HTTPAuth.new(@username, @password)
    client = Teambox::Base.new(httpauth)
    return client.send(method,*args)
  end
end
