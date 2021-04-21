require 'csv'

module Scripts
  class ExpressionEvaluator
    MONETARY_VALUE = 1000.0
    MEASURE_UNIT_AMOUNT = 1.0
    HEADERS = %w[
      commodity_code
      measure_type
      import_date
      monetary_value
      measure_amount
      import_destination
      country_of_origin
      duty_calculation
  ].freeze

    attr_reader :commodity_codes, :import_destination, :country_of_origin, :commodity_code

    def initialize(commodity_codes, import_destination = 'xi', country_of_origin = 'gb')
      @commodity_codes = commodity_codes
      @import_destination = import_destination
      @country_of_origin = country_of_origin
    end

    def result
      CSV.open('evaluation_result.csv', 'w') do |csv|
        csv << HEADERS

        commodity_codes.each do |comm_code|
          begin
            commodity = filtered_commodity_for(commodity_code: comm_code)

            @commodity_code = comm_code

            result = DutyCalculator.new(user_session, commodity).result

            formatted_result = result.each_with_object({}) { |e, acc| acc[e[:key]] = e[:evaluation][:values] }

            formatted_result.keys.each do |key|
              csv << [
                comm_code,
                key,
                as_of,
                MONETARY_VALUE,
                MEASURE_UNIT_AMOUNT,
                import_destination.upcase,
                country_of_origin.upcase,
                formatted_result[key].map{|r| r.join(' | ')}.join("\n"),
              ] if formatted_result[key].present?
            end
          rescue StandardError => e
            csv << [
              comm_code,
              "ERROR: #{e.message}",
              as_of,
              MONETARY_VALUE,
              MEASURE_UNIT_AMOUNT,
              import_destination.upcase,
              country_of_origin.upcase,
              e.backtrace.first(4).join("\n"),
            ]
          end
        end
      end
    end

    private

    def filtered_commodity_for(commodity_code:, filter: default_filter)
      query = default_query.merge(filter)

      Api::Commodity.build(
        import_destination,
        commodity_code,
        query,
      )
    end

    def as_of
      @as_of ||= Time.zone.today.iso8601
    end

    def default_filter
      { 'filter[geographical_area_id]' => country_of_origin.upcase }
    end

    def default_query
      { 'as_of' => as_of }
    end

    def session
      {
        'answers' => {
          'import_destination' => import_destination.upcase,
          'country_of_origin' => country_of_origin.upcase,
          'customs_value' => {
            'monetary_value' => MONETARY_VALUE,
            'shipping_cost' => nil,
            'insurance_cost' => nil,
          },
          'measure_amount' => {
            'asv' => MEASURE_UNIT_AMOUNT,
            'asvx' => MEASURE_UNIT_AMOUNT,
            'cct' => MEASURE_UNIT_AMOUNT,
            'cen' => MEASURE_UNIT_AMOUNT,
            'ctm' => MEASURE_UNIT_AMOUNT,
            'dap' => MEASURE_UNIT_AMOUNT,
            'dhs' => MEASURE_UNIT_AMOUNT,
            'dtn' => MEASURE_UNIT_AMOUNT,
            'dtne' => MEASURE_UNIT_AMOUNT,
            'dtnf' => MEASURE_UNIT_AMOUNT,
            'dtng' => MEASURE_UNIT_AMOUNT,
            'dtnl' => MEASURE_UNIT_AMOUNT,
            'dtnm' => MEASURE_UNIT_AMOUNT,
            'dtnr' => MEASURE_UNIT_AMOUNT,
            'dtns' => MEASURE_UNIT_AMOUNT,
            'dtnz' => MEASURE_UNIT_AMOUNT,
            'eur' => MEASURE_UNIT_AMOUNT,
            'gfi' => MEASURE_UNIT_AMOUNT,
            'grm' => MEASURE_UNIT_AMOUNT,
            'grt' => MEASURE_UNIT_AMOUNT,
            'hlt' => MEASURE_UNIT_AMOUNT,
            'hmt' => MEASURE_UNIT_AMOUNT,
            'kcc' => MEASURE_UNIT_AMOUNT,
            'kcl' => MEASURE_UNIT_AMOUNT,
            'kgm' => MEASURE_UNIT_AMOUNT,
            'kgma' => MEASURE_UNIT_AMOUNT,
            'kgme' => MEASURE_UNIT_AMOUNT,
            'kgmg' => MEASURE_UNIT_AMOUNT,
            'kgmp' => MEASURE_UNIT_AMOUNT,
            'kgms' => MEASURE_UNIT_AMOUNT,
            'kgmt' => MEASURE_UNIT_AMOUNT,
            'klt' => MEASURE_UNIT_AMOUNT,
            'kma' => MEASURE_UNIT_AMOUNT,
            'kmt' => MEASURE_UNIT_AMOUNT,
            'kni' => MEASURE_UNIT_AMOUNT,
            'kns' => MEASURE_UNIT_AMOUNT,
            'kph' => MEASURE_UNIT_AMOUNT,
            'kpo' => MEASURE_UNIT_AMOUNT,
            'kpp' => MEASURE_UNIT_AMOUNT,
            'ksd' => MEASURE_UNIT_AMOUNT,
            'ksh' => MEASURE_UNIT_AMOUNT,
            'kur' => MEASURE_UNIT_AMOUNT,
            'lpa' => MEASURE_UNIT_AMOUNT,
            'ltr' => MEASURE_UNIT_AMOUNT,
            'ltra' => MEASURE_UNIT_AMOUNT,
            'mil' => MEASURE_UNIT_AMOUNT,
            'mpr' => MEASURE_UNIT_AMOUNT,
            'mtk' => MEASURE_UNIT_AMOUNT,
            'mtq' => MEASURE_UNIT_AMOUNT,
            'mtqc' => MEASURE_UNIT_AMOUNT,
            'mtr' => MEASURE_UNIT_AMOUNT,
            'mwh' => MEASURE_UNIT_AMOUNT,
            'nar' => MEASURE_UNIT_AMOUNT,
            'narb' => MEASURE_UNIT_AMOUNT,
            'ncl' => MEASURE_UNIT_AMOUNT,
            'npr' => MEASURE_UNIT_AMOUNT,
            'tjo' => MEASURE_UNIT_AMOUNT,
            'tne' => MEASURE_UNIT_AMOUNT,
            'tnee' => MEASURE_UNIT_AMOUNT,
            'tnei' => MEASURE_UNIT_AMOUNT,
            'tnej' => MEASURE_UNIT_AMOUNT,
            'tnek' => MEASURE_UNIT_AMOUNT,
            'tnem' => MEASURE_UNIT_AMOUNT,
            'tner' => MEASURE_UNIT_AMOUNT,
            'tnez' => MEASURE_UNIT_AMOUNT,
            'wat' => MEASURE_UNIT_AMOUNT,
          }
        },
        'commodity_source' => 'UK',
        'commodity_code' => commodity_code,
      }
    end

    def user_session
      UserSession.new(session)
    end
  end
end
