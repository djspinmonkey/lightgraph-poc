# frozen_string_literal: true

module Types
  class ActorType < Types::BaseObject
    field :backing_api_url, String, "The base URL for the backing API that requests will be passed through to"
    def backing_api_url = LSPublicAPI::BASE_URL

    field :api_key, String, "The API key used to talk to the backing API."
    def api_key = LSPublicAPI::API_KEY

    field :test, String, "A test field for querying."
    def test
      "You have successfully queried this test field!"
    end
  end
end
