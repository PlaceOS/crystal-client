require "../../spec_helper"

module PlaceOS
  describe Client::APIWrapper::SystemTriggers do
    api = PlaceOS::Client::APIWrapper.new DOMAIN
    client = Client::APIWrapper::SystemTriggers.new api

    system_triggers_json = <<-JSON
    [
      {
        "control_system_id": "Place",
        "webhook_secret": "shh it's a secret"
      }
    ]
    JSON

    system_triggers = Array(JSON::Any).from_json(system_triggers_json).map &.to_json

    describe "#search" do
      it "enumerates all system triggers" do
        WebMock
          .stub(:get, DOMAIN + client.base)
          .with(query: {"limit" => "20", "offset" => "0"}, headers: HEADERS)
          .to_return(body: system_triggers_json)
        result = client.search
        result.size.should eq(1)
        result.first.should be_a(PlaceOS::Client::API::Models::TriggerInstance)
        result.first.control_system_id.should eq("Place")
      end

      it "provides system trigger search" do
        WebMock
          .stub(:get, DOMAIN + client.base)
          .with(query: {"q" => "Place", "limit" => "20", "offset" => "0"}, headers: HEADERS)
          .to_return(body: system_triggers_json)
        result = client.search q: "Place"
        result.size.should eq(1)
        result.first.control_system_id.should eq("Place")
      end
    end

    it "#fetch" do
      WebMock
        .stub(:get, DOMAIN + "#{client.base}/systems-trigger-oOj2lGgsz")
        .to_return(body: system_triggers.first)
      result = client.fetch "systems-trigger-oOj2lGgsz", complete: nil
      result.should be_a(PlaceOS::Client::API::Models::TriggerInstance)
      # result.to_json.should contain("\"control_system_id\":\"Place\",\"enabled\":true,\"triggered\":false,\"important\":false,\"exec_enabled\":false,\"webhook_secret\":\"shh it's a secret\",\"trigger_count\":0}")
    end

    it "#destroy" do
      WebMock
        .stub(:delete, DOMAIN + "#{client.base}/systems-trigger-oOj2lGgsz")
      result = client.destroy "systems-trigger-oOj2lGgsz"
      result.should be_nil
    end

    describe "#create" do
    end

    describe "#update" do
      # id = "sys-G03RF2BVBxP"
      # trigger_id = "trig-G03JhJhxfUH"
      # pp! client.base

      # WebMock
      #   .stub(:put, DOMAIN + "#{client.base}/#{id}/triggers/#{trigger_id}")
      #   .with(
      #     headers: {"Content-Type" => "application/json"},
      #     body: {id:"trig-G03JhJhxfUH",name:"TestTrigger-0ede08b5",updated_at:1603948256,debounce_period:-1,important:true,enabled:true,control_system_id:"sys-G03RF2BVBxP",zone_id:"zone-G03PfSG4YRP",system_name:"TestSystem-0ede08b5",enable_webhook:false,supported_methods:["POST"],activated_count:0,version:0}.to_json
      #     # body: %({"id":"trig-G03JhJhxfUH","name":"TestTrigger-0ede08b5","updated_at":1603948256,"debounce_period":-1,"important":true,"enabled":true,"control_system_id":"sys-G03RF2BVBxP","zone_id":"zone-G03PfSG4YRP","system_name":"TestSystem-0ede08b5","enable_webhook":false,"supported_methods":["POST"],"activated_count":0,"version":0,"actions":{"functions":[],"mailers":[]},"conditions":{"comparisons":[],"time_dependents":[]}})
      #   )
      #   .to_return(body: %({"created_at":1603948256,"updated_at":1604035745,"control_system_id":"sys-G03RF2BVBxP","trigger_id":"trigger-G03J8Cq3alf","zone_id":"zone-G03PfSG4YRP","enabled":true,"triggered":false,"important":true,"exec_enabled":false,"webhook_secret":"187b32d40116559414714d950bce75b82b16a180ff28d2b95b3c00d08e8e07c2","trigger_count":0,"id":"trig-G03JhJhxfUH"}))
      # result = client.update id:"trig-G03JhJhxfUH",name:"TestTrigger-0ede08b5",updated_at:1603948256,debounce_period:-1,important:true,enabled:true,control_system_id:"sys-G03RF2BVBxP",zone_id:"zone-G03PfSG4YRP",system_name:"TestSystem-0ede08b5",enable_webhook:false,supported_methods:["POST"],activated_count:0,version:0
      # result.should be_a(TriggerInstance)

      # # /api/engine/v2/systems/sys-G03RF2BVBxP/triggers/trig-G03JhJhxfUH
      # # {"created_at":1603948256,"updated_at":1604035745,"control_system_id":"sys-G03RF2BVBxP","trigger_id":"trigger-G03J8Cq3alf","zone_id":"zone-G03PfSG4YRP","enabled":true,"triggered":false,"important":true,"exec_enabled":false,"webhook_secret":"187b32d40116559414714d950bce75b82b16a180ff28d2b95b3c00d08e8e07c2","trigger_count":0,"id":"trig-G03JhJhxfUH"}
    end
  end
end
