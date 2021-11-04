require 'json'

commodity_fixtures = %w[
  spec/fixtures/uk/commodities/0102291010.json
  spec/fixtures/uk/commodities/0103921100.json
  spec/fixtures/uk/commodities/0702000007.json
  spec/fixtures/uk/commodities/0809400500.json
  spec/fixtures/uk/commodities/1516209821.json
  spec/fixtures/uk/commodities/7202118000.json
  spec/fixtures/uk/commodities/7202999000.json
  spec/fixtures/xi/commodities/0103921100.json
]

commodity_fixtures.each do |commodity_fixture|
  commodity = JSON.parse(File.read(commodity_fixture))

  import_measures = commodity['import_measures'].map do |measure|
    measure['resolved_measure_components'] = []
    measure['resolved_duty_expression'] = ''

    measure
  end

  export_measures = commodity['export_measures'].map do |measure|
    measure['resolved_measure_components'] = []
    measure['resolved_duty_expression'] = ''

    measure
  end

  commodity['import_measures'] = import_measures
  commodity['export_measures'] = export_measures

  File.write(commodity_fixture, JSON.pretty_generate(commodity))
end
