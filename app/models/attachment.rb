# == Schema Information
#
# Table name: attachments
#
#  id          :integer          not null, primary key
#  title       :string
#  title_url   :string
#  description :text
#  image_url   :string
#  message_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Attachment < ApplicationRecord
  belongs_to :message
end
