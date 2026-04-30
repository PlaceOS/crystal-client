require "./endpoint"

module PlaceOS
  class Client::APIWrapper::Users < Client::APIWrapper::Endpoint
    include Client::APIWrapper::Endpoint::Fetch(User)
    include Client::APIWrapper::Endpoint::Destroy

    getter base : String = "#{API_ROOT}/users"

    def current
      get "#{base}/current", as: User
    end

    def resource_token
      post "#{base}/resource_token", as: ResourceToken
    end

    # Creates a new user.
    def create(
      email : String,
      first_name : String,
      last_name : String,
      authority_id : String,
      password : String? = nil,
      confirm_password : String? = nil,
      card_number : String? = nil,
      groups : Array(String)? = nil,
      image : String? = nil,
      locatable : Bool? = nil,
      staff_id : String? = nil,
      support : Bool? = nil,
      sys_admin : Bool? = nil,
      work_overrides : Hash(String, PlaceOS::Model::User::WorktimePreference)? = nil,
      work_preferences : Array(PlaceOS::Model::User::WorktimePreference)? = nil
    )
      post base, body: from_args, as: User
    end

    # Updates an existing user.
    def update(
      id : String,
      email : String? = nil,
      first_name : String? = nil,
      last_name : String? = nil,
      authority_id : String? = nil,
      password : String? = nil,
      confirm_password : String? = nil,
      card_number : String? = nil,
      groups : Array(String)? = nil,
      image : String? = nil,
      locatable : Bool? = nil,
      staff_id : String? = nil,
      support : Bool? = nil,
      sys_admin : Bool? = nil,
      work_overrides : Hash(String, PlaceOS::Model::User::WorktimePreference)? = nil,
      work_preferences : Array(PlaceOS::Model::User::WorktimePreference)? = nil
    )
      put "#{base}/#{id}", body: from_args, as: User
    end

    # List or search for users.
    #
    # Results maybe filtered by specifying a query - *q* - to search across zone
    # attributes. A small query language is supported within this:
    #
    # Operator | Action
    # -------- | ------
    # `+`      | Matches both terms
    # `|`      | Matches either terms
    # `-`      | Negates a single token
    # `"`      | Wraps tokens to form a phrase
    # `(`  `)` | Provides precedence
    # `~N`     | Specifies edit distance (fuzziness) after a word
    # `~N`     | Specifies slop amount (deviation) after a phrase
    #
    # Up to *limit* zones will be returned, with a paging based on *offset*.
    #
    # Results my also also be limited to those associated with specific *tags*.
    def search(
      q : String? = nil,
      limit : Int = 20,
      offset : Int = 0,
      authority_id : String? = nil,
      include_deleted : Bool = false,
      include_metadata : Bool = false
    )
      get base, params: from_args, as: Array(API::Models::User)
    end
  end
end
