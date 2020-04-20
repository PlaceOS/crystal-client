require "../api/models/zone"
require "./endpoint"

module PlaceOS
  class Client::APIWrapper::Zones < Client::APIWrapper::Endpoint
    getter base : String = "#{API_ROOT}/zones"

    # Interaction
    ###########################################################################

    def execute(
      id : String,
      method : String,
      module_name : String,
      index : Int32 = 1,
      args = nil
    )
      post "#{base}/#{id}/#{module_name}_#{index}/#{method}", body: args
    end

    # Management
    ###########################################################################

    # Creates a new zone.
    def create(
      name : String,
      description : String? = nil,
      tags : String? = nil,
      settings : Settings? = nil,
      triggers : Array(String)? = nil
    )
      post base, body: from_args, as: API::Models::Zone
    end

    # Retrieves all metadata associated with a zone.
    def fetch(id : String)
      get "#{base}/#{id}", as: API::Models::Zone
    end

    # Updates zone attributes or configuration.
    def update(
      id : String,
      name : String? = nil,
      description : String? = nil,
      tags : String? = nil,
      settings : Settings? = nil,
      triggers : Array(String)? = nil
    )
      put "#{base}/#{id}", body: from_args, as: API::Models::Zone
    end

    # Removes a zone.
    def destroy(id : String)
      delete "#{base}/#{id}"
    end

    # Search
    ###########################################################################

    # List or search for zones.
    #
    # Results maybe filtered by specifying a query - *q* - to search across module
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
      tags : String? = nil
    )
      get base, params: from_args, as: Array(API::Models::Zone)
    end

    private getter client

    def initialize(@client : APIWrapper)
    end
  end
end
