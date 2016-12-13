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
