class MessageParser
  # Sets the message to be parsed.
  # @return [Message] message object to be parsed
  # @!scope instance
  attr_reader :message

  # Parses the contents of a Message for URI objects.
  #
  # @param message [Message] message to parse
  def initialize(message)
    @message = message
  end

  # Prases the contents of a Message for URI objects.
  #
  # @return [Array<String>] array of uri objects
  def extract_urls!
    urls = URI.extract(message.body)
    urls.each do |url|
      response = HTTParty.get(url)
      is_image = response.code == 200 && response.headers['Content-Type'].start_with?('image')
      if is_image
        message.attachments.create!(image_url: url)
      else
      	doc = Nokogiri::HTML(response.body)
      	contents = doc.at("meta[name='description']").try(:[], 'content')
        title = doc.at('title').try(:[], 'content')
        message.attachments.create!(title: title, title_url: url, description: contents)
      end      
    end
  end
end