require 'socket'

class DomainsWorker
  include Sidekiq::Worker

  def perform(domain_id)
    domain = Domain.find(domain_id)
    ip_address = IPSocket::getaddress(domain.hostname)
    domain.update_attribute(:origin_ip_address, ip_address)
  end
end