#config/initalizers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], {
  scope: ['email',
    'https://www.googleapis.com/auth/gmail.readonly'],
    access_type: 'offline'}
end

# provider…
# tells Omniauth to initialize the google_oauth2 strategy with a Client ID and Client Secret that you will get from the Google Developer Console shortly.
# scope…
# tells Google which APIs you want to access — in our case, the Gmail API. If you omit the email scope you will receive an insufficientPermission error when you try to authenticate. It throws a similar error even if you’re trying to connect to, e.g., the Google Calendar API, so leave that email bit in there in addition to whatever Google API you’re connecting to.
# access_type: ‘offline’
# tells Google that you want to access the Gmail account even if the account holder is away from the browser.
# Omniauth is going to automatically create a route at localhost:3000/auth/google_oauth2  — no need to define it yourself in the routes file. When a user visits that URL, Omniauth redirects them to Google to authorize their account. After they grant permission, Google redirects them back to your app’s callback URL, and sends along an access token in the HTTP request parameters.
