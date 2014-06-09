class Account < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  has_many :domains
end
