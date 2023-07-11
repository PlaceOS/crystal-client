require "../../spec_helper"

module PlaceOS
  describe Client::APIWrapper::Zones do
    api = PlaceOS::Client::APIWrapper.new DOMAIN
    client = Client::APIWrapper::Settings.new api

    response = %({
      "created_at": 1689065113,
      "updated_at": 1689065304,
      "encryption_level": 1,
      "settings_string": "newkey: 'yep'",
      "keys": [
          "newkey"
      ],
      "parent_type": "control_system",
      "parent_id": "sys-F37O9ZKmUN",
      "id": "sets-Fbjh2JNpG4"
    })

    describe "#create" do
      it "posts to the settings endpoint" do
        WebMock
          .stub(:post, DOMAIN + client.base)
          .with(
            headers: HTTP::Headers{"Content-Type" => "application/json"},
            body: %({"parent_id":"sys-F37O9ZKmUN","settings_string":"newkey: 'yep'","encryption_level":1}),
          )
          .to_return(body: response)

        result = client.create "sys-F37O9ZKmUN", "newkey: 'yep'", Encryption::Level::Support
        result.should be_a(Client::API::Models::Settings)
      end
    end
  end
end
