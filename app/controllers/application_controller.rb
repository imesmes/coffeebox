class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      @username = username
      @password = password
    end
  end

  def teambox_api_call(url)
    http = Net::HTTP.new("teambox.com", 443)
    http.use_ssl = true
    http.start do |http|
      req = Net::HTTP::Get.new(url, {})
      req.basic_auth(@username, @password)
      response = http.request(req)
      resp = JSON.parse(response.body)
      return resp["objects"]
    end
  end
end
