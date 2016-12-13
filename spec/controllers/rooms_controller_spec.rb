require "rails_helper"

RSpec.describe RoomsController, type: :controller do

  let(:user) {create(:user)}
  let(:room) {create(:room)}

  context "Authorized user" do

    before(:each) do
      sign_in user
    end

    describe "empty room" do
      it "shows room" do
        get :show, id: room.id
        expect(assigns(:room)).to be_an_instance_of(Room)
      end
    end

    describe "room with messages" do
      it "shows messages" do
        messages = create_list(:message, 10, user: user, room: room)
        get :show, id: room.id
        expect(assigns(:room).messages).to eq messages
      end
    end

  end
end