require 'spec_helper'

describe Microservices::Messages, api: true  do

  describe "GET /api/v1/ping" do
    let(:base_url) { "/api/v1/ping" }

    context "wrong request" do
      it "returns error" do
        get base_url + "random_stuff"

        expect(response).to have_http_status(404)
      end
    end

    context "correct request" do
      it "returns default" do
        get base_url

        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response['ping']).to eq 'pong'
      end

      it "returns param" do
        get base_url, pong: 'ping'

        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response['ping']).to eq 'ping'
      end
    end
  end

end
