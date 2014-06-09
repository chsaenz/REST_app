class Domain < ActiveRecord::Base
  belongs_to :account
  validates :account_id, presence: true
  validates :hostname, uniqueness: true, presence: true
  validates :origin_ip_address, presence: true
end
