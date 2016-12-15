module Microservices
  class Messages < Grape::API
    helpers Microservices::Helpers::Messages
    before { authenticate_user_from_token! }

    desc 'Messages'
    params do
      requires :id, types: [String, Integer], desc: 'Room id'
    end
    resource :rooms do
      desc 'Get all messages' do
        success Entities::Message
      end
      get ':id/messages' do
        messages = Room.find(params[:id]).messages
        present messages, with: Entities::Message
      end

      desc 'Create a message' do
        success Entities::Message
      end
      params do
        requires :message, type: Hash, desc: 'Message object' do
          requires :body, type: String, desc: 'Message body'
        end
      end
      post ':id/messages' do
        message = build_message(params, current_user)
        
        if message.save
          present message, with: Entities::Message
        else
          error!("Failed to save message #{message.errors.messages}", 422)
        end
      end
    end
  end
end
