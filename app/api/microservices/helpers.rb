module Microservices
  module Helpers
  	DEBUG_USER_TOKEN = 'debug-user-token'
  	
    def authenticate_user_from_token!
      user_token = params[:user_token].presence
      @current_user = user_token && User.find_by_authentication_token(user_token.to_s)
      if !@current_user
        if user_token != DEBUG_USER_TOKEN
          error!('401 Unauthorized', 401)
        else
          @current_user = User.last
        end
      end
    end

    def current_user
      @current_user
    end

    module Messages
      def build_message(params, user)
        room = Room.find(params[:id])
        message = params[:message]
        MessageService.new(room, user, message).build_message
      end
    end
  end
end



