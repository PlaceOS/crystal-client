require "placeos-models/user"
require "./response"

module PlaceOS::Client::API::Models
  # Metadata about the current user
  struct User < Response
    @[JSON::Field(converter: Time::EpochConverter)]
    getter created_at : Time

    getter id : String
    getter email_digest : String
    getter nickname : String?
    getter name : String
    getter first_name : String?
    getter last_name : String?
    getter groups : Array(String)?
    getter country : String?
    getter building : String?
    getter image : String?
    getter authority_id : String
    getter deleted : Bool?
    getter department : String?
    getter preferred_language : String?
    getter work_preferences : Array(PlaceOS::Model::User::WorktimePreference) = [] of PlaceOS::Model::User::WorktimePreference
    getter work_overrides : Hash(String, PlaceOS::Model::User::WorktimePreference) = {} of String => PlaceOS::Model::User::WorktimePreference

    # Admin only fields
    getter sys_admin : Bool?
    getter support : Bool?
    getter email : String
    getter phone : String?
    getter ui_theme : String?
    getter metadata : String?
    getter login_name : String?
    getter staff_id : String?
    getter card_number : String?
    getter misc : String?

    getter associated_metadata : Hash(String, Metadata)?
  end

  struct ResourceToken < Response
    getter token : String
    getter expires : Int64?
  end
end
