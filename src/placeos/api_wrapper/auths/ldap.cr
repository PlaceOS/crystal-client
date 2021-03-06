require "./base"

module PlaceOS
  # :nodoc:
  alias LdapAuthentication = Client::API::Models::LdapAuthentication

  class Client::APIWrapper::Ldap < Client::APIWrapper::AuthBase(LdapAuthentication)
    getter base : String = "#{API_ROOT}/ldap_auths"

    def create(
      name : String,
      authority_id : String,
      host : String,
      base : String,
      port : Int32? = nil,
      auth_method : String? = nil,
      uid : String? = nil,
      bind_dn : String? = nil,
      password : String? = nil,
      filter : String? = nil
    )
      super(**args)
    end

    def update(
      id : String,
      name : String? = nil,
      authority_id : String? = nil,
      port : Int32? = nil,
      auth_method : String? = nil,
      uid : String? = nil,
      host : String? = nil,
      base : String? = nil,
      bind_dn : String? = nil,
      password : String? = nil,
      filter : String? = nil
    )
      super(**args)
    end
  end
end
