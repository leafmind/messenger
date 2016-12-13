json.extract! attachment, :id, :title, :title_url, :description, :image_url, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)