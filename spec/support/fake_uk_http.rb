class FakeUkttHttp
  def initialize(host = nil, version = nil, debug = false, conn = nil); end

  def retrieve(resource, _format = 'jsonapi')
    json = case resource
           when %r{^commodities/\d{10}.json$} then read('commodity.json')
           when %r{^geographical_areas$} then read('geographical_areas.json')
           when %r{^geographical_areas/countries$} then read('countries.json')
           else
             raise "Missing fixture. You will want to add a new fixture for resource #{resource}"
           end

    JSON.parse(json)
  end

  def config
    {}
  end

  private

  def read(fixture)
    fixture_path = "#{::Rails.root}/spec/fixtures"
    path = File.join(fixture_path, fixture)

    File.read(path)
  end
end
