require 'httpclient'
require 'json'
require_relative 'rest_reader'
require_relative 'crest_reader'
require_relative 'json_cache'


def show(resp)
  puts JSON.pretty_generate(resp)
end


reader = CrestReader.new
root = reader.root
groups = reader.groups
regions = reader.regions
types = reader.types
market_prices = reader.market_prices

def get_id(url)
  /(\d+)\/$/.match(url)[1]
end


def put_json(data)
  puts JSON.pretty_generate(data)
end

def region_report
  id = get_id(regions['items'].first['href'])
  put_json reader.region(id)
end

def group_report
  groups['items'].map do |group|
    unless group.has_key? 'parentGroup'
      puts "#{group['name']} - #{group['description']}"
    end
  end
end
