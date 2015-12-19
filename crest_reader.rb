class CrestReader
  def initialize
    @api = RestReader.new('https://public-crest.eveonline.com', 'crest')
  end

  def root
    api.get('/')
  end

  def map # broken
    api.get('/map/')
  end

  def market_prices
    api.get('/market/prices/')
  end

  def types
    api.get('/types')
  end

  def groups
    api.get('/market/groups/')
  end

  def regions
    api.get('/regions/')
  end

  def region(id)
    api.get("/regions/#{id}/")
  end

  private

  attr_reader :api
end

