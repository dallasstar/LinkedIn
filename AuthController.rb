require 'rubygems'
require 'linkedin'

class AuthController < ApplicationController

  def index
    client = LinkedIn::Client.new("s2G6xce6bVU8VWPg9EzuxdqI2fOdt_UzdFT3Be4dWOzBhd5pLeV-dHSGdDgihUFC", "jGBodIArZhwt-lasTM1EyFj1rIg2UmJe13pqUd6a-RsScdRAEkunXggjSMc_frMX")
    request_token = client.request_token(:oauth_callback => 
                                      "http://#{request.host_with_port}/auth/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret

    redirect_to client.request_token.authorize_url

  end

  def callback
    client = LinkedIn::Client.new("s2G6xce6bVU8VWPg9EzuxdqI2fOdt_UzdFT3Be4dWOzBhd5pLeV-dHSGdDgihUFC", "jGBodIArZhwt-lasTM1EyFj1rIg2UmJe13pqUd6a-RsScdRAEkunXggjSMc_frMX")
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @profile = client.profile
    @connections = client.connections
  end
end
