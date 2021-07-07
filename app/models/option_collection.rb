class OptionCollection
  include Enumerable

  def initialize(options)
    @options = options
  end

  def each(&block)
    @options.each(&block)
  end

  def <<(option)
    @options << option
  end

  def uniq(&block)
    self.class.new(super(&block))
  end

  def size
    @options.size
  end

  def sort_by(&block)
    self.class.new(super(&block))
  end

  def tariff_preference_options
    @tariff_preference_options ||= select { |option| option[:evaluation][:category] == DutyOptions::TariffPreference::CATEGORY }
  end

  def suspension_options
    @suspension_options ||= select { |option| option[:evaluation][:category] == DutyOptions::Suspension::Base::CATEGORY }
  end

  def third_country_tariff_options
    @third_country_tariff_options ||= select { |option| option[:evaluation][:category] == DutyOptions::ThirdCountryTariff::CATEGORY }
  end

  def cheapest_tariff_preference_option
    @cheapest_tariff_preference_option ||= tariff_preference_options.min_by { |option| option[:evaluation][:value] }
  end

  def cheapest_suspension_option
    @cheapest_suspension_option ||= suspension_options.min_by { |option| option[:evaluation][:value] }
  end

  def third_country_tariff_option
    @third_country_tariff_option ||= find { |option| option[:key] == DutyOptions::ThirdCountryTariff.id }
  end
end
