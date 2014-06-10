class NameValidator < ActiveModel::Validator
  def validate(domain)
    unless PublicSuffix.valid?(domain.hostname)
      domain.errors[:hostname] << 'Hostname is not valid'
    end
  end
end

class Domain < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with NameValidator

  belongs_to :account
  validates :account_id, presence: true
  validates :hostname, uniqueness: true, presence: true

end
