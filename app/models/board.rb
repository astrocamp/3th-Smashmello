class Board < ApplicationRecord
  #vilidates
  validates :title, :visibility, presence: true

  #ActiveRecord關聯設定
  has_many :lists
  has_many :cards
  
  has_many :user_boards
  has_many :users, through: :user_boards

  has_many :board_messages, inverse_of: :board

end