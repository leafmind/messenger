# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  body        :text
#  sender_name :string
#  sent_at     :datetime
#  user_id     :integer
#  room_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  has_many :attachments

  validates :body, presence: true, length: {minimum: 1, maximum: 1000}

  after_create_commit { BroadcastJob.perform_later(self) }
  before_save { self.sender_name = self.user.name }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end

end
