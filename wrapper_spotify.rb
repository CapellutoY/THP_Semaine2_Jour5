#integration des gemmes/librairies dans le .rb#
require 'dotenv'
require 'base64'
require 'httparty'
#ici on encode les cles en base 64#
def encoding
    Dotenv.load #Charge les cles depuis le .env#
    keys = "#{ENV["Client_ID"]}:#{ENV["Client_Secret"]}"
    key_encoded = Base64.strict_encode64(keys)
    key_encoded = "Basic #{key_encoded}"
    return key_encoded
end
#Ici on demande l'autorisation et les tokens d'acces par consequent#
def request_post
    url = "https://accounts.spotify.com/api/token"

    options = {
        headers: {
                "Authorization" => encoding,
        },
        body: {
                "grant_type" => 'client_credentials',
        }
    }

    return my_request = HTTParty.post(url, options)
end
#reset un token a chaque lancement#
def request_get(token)
    url = "https://api.spotify.com/v1/browse/new-releases?limit=2"

    options = {
        headers: {
                "Content-Type": 'application/json',
                "Accept": 'application/json',
                "Authorization": "Bearer #{token}"
        }
    }

    return my_request = HTTParty.get(url, options)
end

puts request_get(request_post["access_token"])
