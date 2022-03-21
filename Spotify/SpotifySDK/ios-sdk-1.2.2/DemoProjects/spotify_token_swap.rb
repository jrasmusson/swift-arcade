require 'sinatra'
require 'net/http'
require 'net/https'
require 'base64'
require 'json'
require 'encrypted_strings'

# This is an example token swap service written
# as a Ruby/Sinatra service. This is required by
# the iOS SDK to authenticate a user.
#
# The service requires the Sinatra and
# encrypted_strings gems be installed:
#
# $ gem install sinatra encrypted_strings
#
# To run the service, enter your client ID, client
# secret and client callback URL below and run the
# project.
#
# $ ruby spotify_token_swap.rb
#
# IMPORTANT: The example credentials will work for the
# example apps, you should use your own in your real
# environment. as these might change at any time.
#
# Once the service is running, pass the public URI to
# it (such as http://localhost:1234/swap if you run it
# with default settings on your local machine) to the
# token swap method in the iOS SDK:
#
# SPTConfiguration *configuration = [SPTConfiguration configurationWithClientID:@"044b2c45e77f45aca8da89e338849b6a"
#                                                                   redirectURL:[NSURL URLWithString:@"spotify-login-sdk-test-app://spotify-login-callback"]];
# configuration.tokenSwapURL = [NSURL urlWithString:@"http://localhost:1234/swap"];
# configuration.tokenRefreshURL = [NSURL urlWithString:@"http://localhost:1234/refresh"];
#

print "\e[31m------------------------------------------------------\e[0m\n"
print "\e[31mYou're using example credentials, please replace these\e[0m\n"
print "\e[31mwith your own and remove this silly warning.\e[0m\n"
print "\e[31m------------------------------------------------------\e[0m\n"
print "\7\7"
sleep(2)
CLIENT_ID = "044b2c45e77f45aca8da89e338849b6a"
CLIENT_SECRET = "c7d838bc6f3d40889cb11517afc8e3f3"
ENCRYPTION_SECRET = "cFJLyifeUJUBFWdHzVbykfDmPHtLKLGzViHW9aHGmyTLD8hGXC"
CLIENT_CALLBACK_URL = "spotify-login-sdk-test-app://spotify-login-callback"
AUTH_HEADER = "Basic " + Base64.strict_encode64(CLIENT_ID + ":" + CLIENT_SECRET)
SPOTIFY_ACCOUNTS_ENDPOINT = URI.parse("https://accounts.spotify.com")

set :port, 1234 # The port to bind to.
set :bind, '0.0.0.0' # IP address of the interface to listen on (all)


post '/swap' do

    # This call takes a single POST parameter, "code", which
    # it combines with your client ID, secret and callback
    # URL to get an OAuth token from the Spotify Auth Service,
    # which it will pass back to the caller in a JSON payload.

    auth_code = params[:code]

    http = Net::HTTP.new(SPOTIFY_ACCOUNTS_ENDPOINT.host, SPOTIFY_ACCOUNTS_ENDPOINT.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new("/api/token")

    request.add_field("Authorization", AUTH_HEADER)

    request.form_data = {
        "grant_type" => "authorization_code",
        "redirect_uri" => CLIENT_CALLBACK_URL,
        "code" => auth_code
    }

    response = http.request(request)

    # encrypt the refresh token before forwarding to the client
    if response.code.to_i == 200
        token_data = JSON.parse(response.body)
        refresh_token = token_data["refresh_token"]
        encrypted_token = refresh_token.encrypt(:symmetric, :password => ENCRYPTION_SECRET)
        token_data["refresh_token"] = encrypted_token
        response.body = JSON.dump(token_data)
    end

    status response.code.to_i
    return response.body
end

post '/refresh' do

    # Request a new access token using the POST:ed refresh token

    http = Net::HTTP.new(SPOTIFY_ACCOUNTS_ENDPOINT.host, SPOTIFY_ACCOUNTS_ENDPOINT.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new("/api/token")

    request.add_field("Authorization", AUTH_HEADER)

    encrypted_token = params[:refresh_token]
    refresh_token = encrypted_token.decrypt(:symmetric, :password => ENCRYPTION_SECRET)

    request.form_data = {
        "grant_type" => "refresh_token",
        "refresh_token" => refresh_token
    }

    response = http.request(request)

    status response.code.to_i
    return response.body

end
