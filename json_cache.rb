class JSONCache
  CACHE_DIR = './cache/'

  def initialize(cache_name)
    @cache_name = cache_name
    @cached_data = load_cache
  end

  def read(endpoint, refresh = false)
    puts 'read'
    if refresh || missing?(endpoint)
      yield.tap do |data|
        put(endpoint, data)
      end
    else
      get(endpoint)
    end
  end

  private

  attr_reader :cache_name, :cached_data

  def put(endpoint, data)
    cached_data[endpoint] = data
    persist
  end

  def get(endpoint)
    puts 'get'
    cached_data[endpoint]
  end

  def missing?(endpoint)
    ! cached_data.key?(endpoint)
  end

  def load_cache
    puts 'loading'
    if File.exists? cache_file
      File.open(cache_file, 'r') do |f|
        JSON.load(f)
      end
    else
      {}
    end
  end

  def persist
    puts 'persisting'
    File.open(cache_file, 'w') do |f|
      f.write(JSON.pretty_generate(cached_data))
    end
  end

  def cache_file
    "#{CACHE_DIR}#{cache_name}.json"
  end

end
