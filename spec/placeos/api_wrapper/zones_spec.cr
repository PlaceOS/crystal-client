require "../../spec_helper"

module PlaceOS
  describe Client::APIWrapper::Zones do
    api = PlaceOS::Client::APIWrapper.new DOMAIN
    client = Client::APIWrapper::Zones.new api

    zones_json = <<-JSON
    [
      {
        "name": "Place",
        "description": null,
        "tags": ["org"],
        "triggers": [],
        "created_at": 1555995992,
        "updated_at": 1555996000,
        "id": "zone-oOj2lGgsz",
        "count": 0,
        "capacity": 2
      }
    ]
    JSON

    zones = Array(JSON::Any).from_json(zones_json).map &.to_json

    describe "#search" do
      it "enumerates all zones" do
        WebMock
          .stub(:get, DOMAIN + client.base)
          .with(query: {"limit" => "20", "offset" => "0"}, headers: HEADERS)
          .to_return(body: zones_json)
        result = client.search
        result.size.should eq(1)
        result.first.should be_a(PlaceOS::Model::Zone)
        result.first.name.should eq("Place")
      end

      it "provides zone search" do
        WebMock
          .stub(:get, DOMAIN + client.base)
          .with(query: {"q" => "Place", "limit" => "20", "offset" => "0"}, headers: HEADERS)
          .to_return(body: zones_json)
        result = client.search q: "Place"
        result.size.should eq(1)
        result.first.name.should eq("Place")
      end
    end

    describe "#create" do
      it "posts to the zones endpoint" do
        body = {name: "Place"}.to_json
        WebMock
          .stub(:post, DOMAIN + client.base)
          .with(
            headers: HTTP::Headers{"Content-Type" => "application/json"},
            body: body,
          )
          .to_return(body: zones.first)
        result = client.create name: "Place"
        result.should be_a(PlaceOS::Model::Zone)
      end
    end

    describe "#fetch" do
      it "inspects a zones metadata" do
        WebMock
          .stub(:get, DOMAIN + "#{client.base}/zone-oOj2lGgsz")
          .to_return(body: zones.first)
        result = client.fetch "zone-oOj2lGgsz"
        result.should be_a(PlaceOS::Model::Zone)
      end
    end

    describe "#update" do
      it "send a put request to the zones endpoint" do
        WebMock
          .stub(:put, DOMAIN + "#{client.base}/zone-oOj2lGgsz")
          .with(
            headers: HTTP::Headers{"Content-Type" => "application/json"},
            body: {name: "Foo"}.to_json,
          )
          .to_return(body: zones.first)
        result = client.update(id: "zone-oOj2lGgsz", name: "Foo")
        result.should be_a(PlaceOS::Model::Zone)
      end
    end

    describe "#destroy" do
      it "execs a delete request" do
        WebMock
          .stub(:delete, DOMAIN + "#{client.base}/zone-oOj2lGgsz")
        result = client.destroy "zone-oOj2lGgsz"
        result.should be_nil
      end
    end

    describe "#execute" do
      # TODO
      pending "should exec execute" do
        body = {id: "zone-oOj2lGgsz", method: "string", module_name: "string"}.to_json
        WebMock
          .stub(:post, DOMAIN + "#{client.base}/zone-oOj2lGgsz/module_name_1/method")
          .with(
            headers: HTTP::Headers{"Content-Type" => "application/json"},
            body: {id: "zone-oOj2lGgsz", method: "string", module_name: "string"}.to_json,
          )
          .to_return(body: body)
        result = client.execute id: "zone-oOj2lGgsz", method: "string", module_name: "string"
        result.should be_a(PlaceOS::Model::Zone)
      end
    end

    describe "#trigger" do
      it "should exec trigger" do
        WebMock
          .stub(:get, DOMAIN + "#{client.base}/zone-oOj2lGgsz/triggers")
          .to_return(body: zones.first)
        result = client.trigger "zone-oOj2lGgsz"
        result.should be_a(PlaceOS::Model::Zone)
        result.to_json.should eq("{\"created_at\":1555995992,\"updated_at\":1555996000,\"name\":\"Place\",\"description\":\"\",\"tags\":[\"org\"],\"count\":0,\"capacity\":2,\"triggers\":[]}")
      end
    end
  end
end
