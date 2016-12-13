require 'spec_helper'

describe Microservices::Messages, api: true  do

  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:room) { create(:room) }

  describe "GET /api/v1/rooms/:id/messages" do
    let(:base_url) { "/api/v1/rooms/#{room.id}/messages" }

    context "when unauthenticated" do
      it "returns authentication error" do
        get base_url

        expect(response).to have_http_status(401)
      end
    end

    context "when authenticated" do
      it "returns all messages with attachments" do
        message = create(:message, :with_attachment, room: room, user: user)
        get base_url, user_token: user.authentication_token

        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_an Array
        expect(json_response.length).to eq(1)
        expect(json_response.first['id']).to eq(message.id)
      end
    end
  end

end
