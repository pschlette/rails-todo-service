class User < ActiveRecord::Base
  attr_accessible :name, :password
  has_many :todos
  validates :name, presence: true
  validates :password, presence: true
end
