module Api
  class MeasureType < Api::Base
    TYPE_OPTION_MAPPING = {
      '103' => ::DutyOptions::ThirdCountryTariff,
      '105' => ::DutyOptions::ThirdCountryTariff,
      '112' => ::DutyOptions::Suspension::Autonomous,
      '115' => ::DutyOptions::Suspension::AutonomousEndUse,
      '117' => ::DutyOptions::Suspension::CertainCategoryGoods,
      '119' => ::DutyOptions::Suspension::Airworthiness,
      '142' => ::DutyOptions::TariffPreference,
      '145' => ::DutyOptions::TariffPreference,
      '106' => ::DutyOptions::TariffPreference,
      '122' => ::DutyOptions::Quota::NonPreferential,
      '123' => ::DutyOptions::Quota::NonPreferentialEndUse,
      '143' => ::DutyOptions::Quota::Preferential,
      '146' => ::DutyOptions::Quota::PreferentialEndUse,
    }.freeze

    TYPE_ADDITIONAL_OPTION_MAPPING = {
      '551' => ::DutyOptions::AdditionalDuty::ProvisionalAntiDumping,
      '552' => ::DutyOptions::AdditionalDuty::DefinitiveAntiDumping,
      '553' => ::DutyOptions::AdditionalDuty::ProvisionalCountervailing,
      '554' => ::DutyOptions::AdditionalDuty::DefinitiveCountervailing,
      '695' => ::DutyOptions::AdditionalDuty::AdditionalDuties,
      '696' => ::DutyOptions::AdditionalDuty::AdditionalDutiesSafeguard,
    }.freeze

    EXCISE_MEASURE_TYPE_IDS = [
      '306', # "Excises"
      'DAA', # "EXCISE - FULL, 411, SPARKLING WINE OF FRESH GRAPE, 8.5% AND ABOVE, BUT NOT EXCEEDING 15%"
      'DAB', # EXCISE - FULL, 412, SPARKLING WINE OF FRESH GRAPE, EXCEEDING 5.5% BUT LESS THAN 8.5%
      'DAC', # EXCISE - FULL, 413, STILL WINE EXC 5.5% NOT EXC 15%
      'DAE', # EXCISE - FULL, 415, STILL OR SPARKLING EXC 15% BUT NOT EXC 22%
      'DAI', # EXCISE - FULL, 419, WINE OF GREATER THAN 22% VOL
      'DBA', # EXCISE - FULL, 421, SPARKLING MADE-WINE EXC 8.5% AND ABOVE BUT NOT EXCEEDING 15%
      'DBB', # EXCISE - FULL, 422, SPARKLING MADE-WINE EXCEEDING 5.5% BUT LESS THAN 8.5%
      'DBC', # EXCISE - FULL, 423, STILL MADE-WINE EXC 5.5% NOT EXC 15%
      'DBE', # EXCISE - FULL, 425, MADE-WINE OF BETWEEN 15%-22% VOL
      'DBI', # EXCISE - FULL, 429, MADE-WINE OF GREATER THAN 22% VOL
      'DCA', # EXCISE - FULL, 431, WINE BASED BEVERAGE OF LESS THAN 1.2% VOL
      'DCC', # EXCISE - FULL, 433, WINE, MADE-WINE EXC 1.2% VOL NOT EXC 4% VOL.
      'DCE', # EXCISE - FULL, 435, WINE, MADE-WINE EXC 4% VOL NOT EXC 5.5% VOL.
      'DCH', # EXCISE - FULL, 438, SPIRIT-BASED COOLERS
      'DDA', # EXCISE - FULL, 441, IMPORTED BEER
      'DDB', # EXCISE - FULL, 442, BEER MADE IN THE UK
      'DDC', # EXCISE - FULL, 443, IMPORTED BEER
      'DDD', # EXCISE - FULL, 444, UK BEER
      'DDE', # EXCISE - FULL, 445, UK BEER
      'DDF', # EXCISE - FULL, 446, IMPORTED BEER
      'DDG', # EXCISE - FULL, 447, IMPORTED BEER
      'DDJ', # EXCISE - FULL, 440, BEER MADE IN THE UK
      'DEA', # EXCISE - FULL, 451, SPIRITS
      'DFA', # EXCISE - FULL, 461, WHISKY - WHOLLY MALT
      'DFB', # EXCISE - FULL, 462, WHISKY - WHOLLY GRAIN
      'DFC', # EXCISE - FULL, 463, WHISKY - BLENDED
      'DGC', # EXCISE - FULL, 473, BEER BASED BEVERAGE EXCEEDING 1.2% VOL.
      'DHA', # EXCISE - FULL, 481, CIDER AND PERRY
      'DHC', # EXCISE - FULL, 483, CIDER AND PERRY EXCEEDING 7.5% BUT LESS THAN 8.5%
      'DHE', # EXCISE - FULL, 485, SPARKLING CIDER and PERRY, STRENGTH EXCEEDING 5.5% BUT LESS THAN 8.5%
      'EAA', # EXCISE - FULL, 511, UNREBATED LIGHT OIL, AVIATION GASOLINE
      'EAE', # EXCISE - FULL, 515, UNREBATED LIGHT OIL, LEADED MOTOR SPIRIT
      'EBA', # EXCISE - FULL, 521, REBATED LIGHT OIL, FURNACE FUEL
      'EBB', # EXCISE - FULL, 522, REBATED LIGHT OIL, UNLEADED FUEL
      'EBE', # EXCISE - FULL, 525, ULTRA LOW SULPHUR PETROL
      'EBJ', # EXCISE - FULL, 520, UNREBATED LIGHT OIL, OTHER
      'EDA', # EXCISE - FULL, 541, UNREBATED HEAVY OIL
      'EDB', # EXCISE - FULL, 542, KEROSENE AS OFF-ROAD MOTOR VEHICLE FUEL
      'EDE', # EXCISE - FULL, 545, ULTRA LOW SULPHER DIESEL
      'EDJ', # EXCISE - FULL, 540, OTHER (UNMARKED) HEAVY OIL (OTHER THAN KEROSENE)
      'EEA', # EXCISE - FULL, 551, REBATED HEAVY OIL, KEROSENE
      'EEF', # EXCISE - FULL, 556, REBATED HEAVY OIL, GAS OIL
      'EFA', # EXCISE - FULL, 561, REBATED HEAVY OIL, FUEL OIL
      'EFJ', # EXCISE - FULL, 560, ULTRA LOW SULPHUR GAS OIL
      'EGA', # EXCISE - FULL, 571, BIODIESEL FOR NON-ROAD USE
      'EGB', # EXCISE - FULL, 572, BIODIESEL BLENDED WITH KEROSENE
      'EGJ', # EXCISE - FULL, 570, REBATED HEAVY OIL, OTHER
      'EHI', # EXCISE - FULL, 589, BIODIESEL - PURE BIODIESEL
      'EIA', # EXCISE - FULL, 591, NATURAL GAS
      'EIB', # EXCISE - FULL, 592, OTHER GAS
      'EIC', # EXCISE - FULL, 593, OTHER RCT EX DTY SULPH FREE DIESEL AND RPT EX DTY SULPH FREE DIESEL
      'EID', # EXCISE - FULL, 594, OTHER RCT EX DTY SULPH FREE PETROL AND RPT EX DTY SULPH FREE PETROL
      'EIE', # EXCISE - FULL, 595, BIOETHANOL
      'EIJ', # EXCISE - FULL, 590, BIODIESEL - BLENDED
      'FAA', # EXCISE - FULL, 611, CIGARATTES
      'FAE', # EXCISE - FULL, 615, CIGARS
      'FAI', # EXCISE - FULL, 619, HAND ROLLING TOBACCO
      'FBC', # EXCISE - FULL, 623, OTHER SMOKING TOBACCO
      'FBG', # EXCISE - FULL, 627, CHEWING TOBACCO
      'LAA', # EXCISE - SUSPENSION, 511, UNREBATED LIGHT OIL, AVIATION GASOLINE
      'LAE', # EXCISE - SUSPENSION, 515, UNREBATED LIGHT OIL, LEADED MOTOR SPIRIT
      'LBA', # EXCISE - SUSPENSION, 521, REBATED LIGHT OIL, FURNACE FUEL
      'LBB', # EXCISE - SUSPENSION, 522, REBATED LIGHT OIL, UNLEADED FUEL
      'LBE', # EXCISE - SUSPENSION, 525, ULTRA LOW SULPHUR PETROL
      'LBJ', # EXCISE - SUSPENSION, 520, UNREBATED LIGHT OIL, OTHER
      'LDA', # EXCISE - SUSPENSION, 541, UNREBATED HEAVY OIL
      'LEA', # EXCISE - SUSPENSION, 551, REBATED HEAVY OIL, KEROSENE
      'LEF', # EXCISE - SUSPENSION, 556, REBATED HEAVY OIL, GAS OIL
      'LFA', # EXCISE - SUSPENSION, 561, REBATED HEAVY OIL, FUEL OIL
      'LGJ', # EXCISE - SUSPENSION, 570, REBATED HEAVY OIL, OTHER
    ].freeze

    SUPPORTED_MEASURE_TYPE_IDS = (TYPE_OPTION_MAPPING.keys + TYPE_ADDITIONAL_OPTION_MAPPING.keys).freeze

    attributes :description,
               :national,
               :measure_type_series_id,
               :id

    enum :measure_type_series_id, {
      applicable_duty: %w[C],
      anti_dumping_and_countervailing_duty: %w[D],
      additional_duty: %w[F],
      countervailing_charge_duty: %w[J],
      unit_price_duty: %w[M],
    }

    def option
      TYPE_OPTION_MAPPING[id]
    end

    def additional_duty_option
      TYPE_ADDITIONAL_OPTION_MAPPING[id]
    end

    def additional_option?
      id.in?(TYPE_ADDITIONAL_OPTION_MAPPING.keys)
    end

    def self.supported_option_category?(category)
      TYPE_OPTION_MAPPING.values.any? { |option_klass| option_klass::CATEGORY == category }
    end
  end
end
