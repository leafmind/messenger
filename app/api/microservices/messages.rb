module Microservices
  class Messages < Grape::API
    before { authenticate_user_from_token! }

    desc 'Creates a spline that can be reticulated.'
    resource :rooms do
      get ':id/messages' do
        messages = Room.find(params[:id]).messages
        present messages, with: Entities::Message
      end

      post ':id/messages' do
        message = Room.find(params[:id]).messages.new(body: params[:body], user: current_user)
        if message.save
          present message, with: Entities::Message
        else
          error!("Failed to save room + #{message.errors.messages}", 422)
        end
      end
    end
  end
end
