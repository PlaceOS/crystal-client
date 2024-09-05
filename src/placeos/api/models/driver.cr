require "./response"
require "./role"

module PlaceOS::Client::API::Models
  struct Driver < Response
    include Timestamps

    getter id : String

    getter name : String
    getter description : String

    getter default_uri : String
    getter default_port : Int32

    getter role : Int32

    def role : Role
      Role.from_value(@role)
    end

    # Driver version management

    getter file_name : String # Path to driver, relative to repository directory
    getter commit : String    # Commit/version of driver to compile

    getter repository_id : String

    # Module instance configuration
    getter module_name : String

    # Don't include this module in statistics or disconnected searches
    # Might be a device that commonly goes offline (like a PC or Display that only supports Wake on Lan)
    getter ignore_connected : Bool
  end
end
