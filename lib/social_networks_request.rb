class SocialNetworksRequest
  PROVIDERS_URL_HASH = {
    twitter: 'https://takehome.io/twitter',
    facebook: 'https://takehome.io/facebook',
    instagram: 'https://takehome.io/instagram'
  }.freeze

  def initialize
    perform_requests
  end

  def serialized_response
    providers_response_hash.to_json
  end

  private

  def providers_response_hash
    @providers_response_hash ||= Concurrent::Hash.new
  end

  def perform_requests
    PROVIDERS_URL_HASH.keys.map do |provider|
      Thread.new do
        perform_request(provider)
      end
    end.each(&:join)
  end

  def perform_request(provider)
    0.upto(max_retry) do
      response = HTTParty.get(PROVIDERS_URL_HASH[provider])
      break if handle_response(provider, response)
    end
  end

  def handle_response(provider, provider_response)
    providers_response_hash[provider] = JSON.parse(provider_response.body)
    true
  rescue JSON::ParserError
    providers_response_hash[provider] = { error: 'ResponseError' }
    false
  rescue StandardError
    providers_response_hash[provider] = { error: 'UndefinedError' }
    false
  end

  def max_retry
    ENV['MAX_RETRY'].to_i || 1
  end
end
