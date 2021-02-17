require 'uktt'

class FakeUkttHttp
  def initialize(host = nil, version = nil, debug = false, conn = nil); end

  def retrieve(resource, _return_json = false)
    json = case resource
           when %r{^commodities/[\d]{10}.json$}
             read('commodity.json')
           else
             raise "Missing fixture. You will want to add a new fixture for resource #{resource}"
           end

    JSON.parse(json, object_class: OpenStruct)
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
