json.array!(@domains) do |domain|
  json.extract! domain, :id, :hostname, :origin_ip_address, :account_id
  json.url domain_url(domain, format: :json)
end
