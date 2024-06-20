require 'sinatra'
require 'json'
require 'phonelib'
require 'sinatra/cross_origin'

class MobileNumberService < Sinatra::Base
  configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options "*" do
    response.headers["Allow"] = "GET, POST, PUT, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept"
    200
  end

  get '/validate' do
    content_type :json
    mobile_number = params['mobile_number']

    # Assume the mobile number should be in international format
    # Add a default country code if necessary
    if mobile_number.length == 8
      mobile_number = "+65" + mobile_number  # Example for Singapore
    end

    valid_number = valid_mobile_number?(mobile_number)

    { valid_mobile_number: valid_number }.to_json
  end

  private

  def valid_mobile_number?(number)
    Phonelib.valid?(number)
  end
end

MobileNumberService.run!
