require './lib/social_networks_request'

class App < Sinatra::Base
  get '/' do
    SocialNetworksRequest.new.serialized_response
  end
end
