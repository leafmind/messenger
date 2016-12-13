class BroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
  	extract_urls(message)
    ActionCable.server.broadcast "chat_rooms_#{message.room.id}_channel",
                                 message: render_message(message)
  end

  private

  def extract_urls(message)
    urls = URI.extract(message.body)
    urls.each do |url|
      response = HTTParty.get(url)
      is_image = response.code == 200 && response.headers['Content-Type'].start_with?('image')
      if is_image
        message.attachments.create(image_url: url)
      else
      	doc = Nokogiri::HTML(response.body)
      	contents = %w[description keywords].map { |name|
          doc.at("meta[name='#{name}']")['content']
        }.join
        title = doc.at('title')['content']
        message.attachments.create(title: title, title_url: url, description: contents)
      end      
    end
  end

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end