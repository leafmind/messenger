class MessageService
  # Sets the message params.
  # @return [Message] message params hash
  # @!scope instance
  attr_reader :message
  attr_reader :room
  attr_reader :user

  # Parses the contents of a Message for URI objects.
  #
  # @param message [Message] message to build
  def initialize(room, user, message)
    @message = message
    @room = room
    @user = user
  end

  def build_message
    room.messages.new(message.merge(user: user))
  end
end