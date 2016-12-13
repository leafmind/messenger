module Microservices
  module Entities
    class Attachment < Grape::Entity
      expose :title
      expose :title_url, :description, :image_url
    end

    class Message < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id
      expose :body, :sender_name

      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end

    class Room < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id
      expose :name

      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end
