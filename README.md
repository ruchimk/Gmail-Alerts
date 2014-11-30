# Create a Rails project for Omniauth and the Gmail API

### Following tutorial to learn how to:
* Create a Rails app with the the gems needed to connect to a Google API
* Configure Omniauth to perform the Oauth dance with Google
* Set up your app on the Google developer portal
* Save and refresh your Google API access token

https://www.twilio.com/blog/2014/09/gmail-api-oauth-rails.html

Lessons Learned: Google access tokens expire in 60 minutes, and neither the Google API gem nor Omniauth have a built in method to refresh access tokens so we have to write it ourselves(refer to the tokens.rb file to see how).

to_params
Converts the token’s attributes into a hash with the key names that the Google API expects for a token refresh. For more information on why these are the way they are, check out the docs for how to refresh a Google API token.
request_token_from_google
Makes a http POST request to the Google API OAuth 2.0 authorization endpoint using parameters from above. Google returns JSON data that includes an access token good for another 60 minutes. Again, the the Google API docs have more information on how this works.
refresh!
Requests the token from Google, parses its JSON response and updates your database with the new access token and expiration date.
expired?
Returns true if your access token smells like spoiled milk.
fresh_token
A convenience method to return a valid access token, refreshing if necessary.
One last note about the tokens table: for simplicity’s sake I wrote this tutorial to only work with a single email address but it won’t be difficult to add support for multiple accounts if you build a service for multiple users. Google sends the users’s email address to the callback url. Add an email column to the tokens table, and save the email address in sessions#create, then retrieve the corresponding token when needed.
However, for the purpose of this tutorial, your token will always be found at Token.last. To make sure this all works, open a Rails console and type:
t = Token.last
puts t.access_token
t.refresh!
puts t.access_token
then..
t.fresh_token 

"In Part 2, we’ll learn how to get emails from the Gmail API and send SMS alerts using Twilio. If you’ve got any ideas for integrating Google and Twilio, or have any questions, hit me up at gb@twilio.com or on Twitter at @greggyb."
