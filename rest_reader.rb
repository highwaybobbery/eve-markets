class RestReader
  def initialize(base_url, cache_name)
    @base_url = base_url
    @json_cache = JSONCache.new(cache_name)
  end

  def get(endpoint, refresh=false)
    json_cache.read(endpoint, refresh) do
      JSON.parse(client.get(endpoint).body)
    end
  end

  private

  attr_reader :base_url, :json_cache

  def client
    @client ||= begin
      HTTPClient.new.tap do |client|
        client.base_url = base_url
      end
    end
  end

end
