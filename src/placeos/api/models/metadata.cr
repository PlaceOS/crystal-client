require "./response"

module PlaceOS::Client::API::Models
  struct Metadata < Response
    getter name : String
    getter description : String
    getter details : JSON::Any
    getter parent_id : String
    getter schema_id : String?
    getter editors : Array(String)?
    getter modified_by_id : String?
  end
end
