require "./endpoint"
require "yaml"

module PlaceOS
  class Client::APIWrapper::Settings < Client::APIWrapper::Endpoint
    include Client::APIWrapper::Endpoint::Fetch(API::Models::Settings)
    include Client::APIWrapper::Endpoint::Destroy

    # Management
    ###########################################################################

    # Create new settings.
    def create(
      parent_id : String,
      settings_string : String,
      encryption_level : Encryption::Level = Encryption::Level::Support
    )
      YAML.parse(settings_string)
      create_actual(parent_id, settings_string, encryption_level.to_i)
    end

    protected def create_actual(
      parent_id : String,
      settings_string : String,
      encryption_level : Int32
    )
      post base, body: from_args, as: API::Models::Settings
    end

    # Update settings.
    def update(
      id : String,
      settings_string : String
    )
      YAML.parse(settings_string)
      put "#{base}/#{id}", body: from_args, as: API::Models::Settings
    end

    getter base : String = "#{API_ROOT}/settings"
  end
end
