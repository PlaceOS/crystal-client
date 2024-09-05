require "http/client/response"

class PlaceOS::Client::API::Error < Exception
  def self.from_response(response : HTTP::Client::Response)
    if response.success?
      # Shouldn't ever be passed through here...
      raise ArgumentError.new "response is valid"
    elsif response.status_message
      new "#{response.status_message}\n#{response.body}"
    else
      new "HTTP error #{response.status_code}\n#{response.body}"
    end
  end
end
