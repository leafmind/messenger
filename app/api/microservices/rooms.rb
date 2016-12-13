module Microservices
  class Rooms < Grape::API
    before { authenticate_user_from_token! }
    
    resource :rooms do
      desc 'Get a room list' do
        success Entities::Room
      end
      params do
        optional :search, type: String, desc: 'Search for a specific room'
      end
      get do
        present Room.all, with: Entities::Room
      end

      desc 'Create a room. Available only for users who can create rooms.' do
        success Entities::Room
      end
      params do
        requires :name, type: String, desc: 'The name of the room'
      end
      post do
        room = Room.create(name: params[:name])

        if room.persisted?
          present room, with: Entities::Room
        else
          error!("Failed to save room #{room.errors.messages}", 422)
        end
      end
    end
  end
end
