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
    getter work_preferences : Array(WorktimePreference) = [] of WorktimePreference
    getter work_overrides : Hash(String, WorktimePreference) = {} of String => WorktimePreference

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

    # day_of_week: Index of the day of the week. `0` being Sunday
    # start_time: Start time of work hours. e.g. `7.5` being 7:30AM
    # end_time: End time of work hours. e.g. `18.5` being 6:30PM
    # location: Name of the location the work is being performed at
    record WorktimePreference, day_of_week : Int64, start_time : Float64, end_time : Float64, location : String = "" do
      include JSON::Serializable
    end
  end

  struct ResourceToken < Response
    getter token : String
    getter expires : Int64?
  end
end
