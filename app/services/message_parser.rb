class MessageParser
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def extract_urls!
    urls = URI.extract(message.body)
    urls.each do |url|
      response = HTTParty.get(url)
      is_image = response.code == 200 && response.headers['Content-Type'].start_with?('image')
      if is_image
        message.attachments.create!(image_url: url)
      else
      	doc = Nokogiri::HTML(response.body)
      	contents = doc.at("meta[name='#{description}']")['content']
        title = doc.at('title')['content']
        message.attachments.create!(title: title, title_url: url, description: contents)
      end      
    end
  end
end