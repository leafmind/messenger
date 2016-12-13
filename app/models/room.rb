# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :name, presence: true, uniqueness: true, case_sensitive: false
end
