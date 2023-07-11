require "placeos-models/utilities/encryption"

require "./response"

module PlaceOS::Client::API::Models
  struct Settings < Response
    getter id : String
    @[JSON::Field(converter: Enum::ValueConverter(PlaceOS::Encryption::Level))]
    getter encryption_level : Encryption::Level
    getter settings_string : String = "{}"
    getter keys : Array(String) = [] of String
    getter parent_id : String
    getter parent_type : String
  end
end
