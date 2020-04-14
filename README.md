# Description

  I choose Sinatra since is a light weight option, with enough features to make the development process easy.

  To run the app, first you need to run `bundle install`, and run the app with `rackup -p 3000`.

  The app can perform retries to the different providers in case of an unsuccessful response.
  The number of retries can be set with the environmental variable `MAX_RETRY`. It defaults to one. This is a simple approximation to what could be needed to handle some response errors or query throttling.

  In case of an error in the response from the different providers, two different messages can be returned within the response: `{..., [PROVIDER_NAME]: { error: 'ResponseError' }}` or `{..., [PROVIDER_NAME]: { error: 'UndefinedError' }}`
