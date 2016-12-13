require 'spec_helper'

describe Microservices::Rooms, api: true  do

  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:room) { create(:room) }

  describe "GET /api/v1/rooms/" do
    let(:base_url) { "/api/v1/rooms" }

    context "when unauthenticated" do
      it "returns authentication error" do
        get base_url

        expect(response).to have_http_status(401)
      end
    end

    context "when authenticated" do
      it "returns all rooms" do
        get base_url, user_token: user.authentication_token

        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_an Array
        expect(json_response.length).to eq(1)
        expect(json_response.first['id']).to eq(room.id)
      end
    end
  end

  describe "GET /api/v1/rooms/:id/messages" do
    let(:base_url) { "/api/v1/rooms/#{room.id}/messages" }

    context "when unauthenticated" do
      it "returns authentication error" do
        get base_url

        expect(response).to have_http_status(401)
      end
    end

    context "when authenticated" do
      it "returns all messages" do
        message = create(:message, room: room, user: user)
        get base_url, user_token: user.authentication_token

        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response).to be_an Array
        expect(json_response.length).to eq(1)
        expect(json_response.first['id']).to eq(message.id)
      end
    end
  end

  describe "POST /api/v1/rooms/:id/messages" do
    let(:base_url) { "/api/v1/rooms/#{room.id}/messages" }
    let(:token_user) { create(:user) }

    it 'creates a new message' do
      msg_body = build(:message).body
      post base_url, {user_token: token_user.authentication_token, body: msg_body}

      expect(response).to have_http_status(201)
      json_response = JSON.parse(response.body)
      expect(json_response['body']).to eq(msg_body)
      expect(json_response['sender_name']).to eq(token_user.name)
    end

    it 'returns 400 when creating a new message if it is invalid' do
      post base_url, {user_token: token_user.authentication_token, body: ''}

      expect(response).to have_http_status(422)
    end

  end

end
