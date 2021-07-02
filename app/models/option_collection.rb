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

  def sort_by(&block)
    self.class.new(super(&block))
  end

  def preferences
    @preferences ||= select { |option| option[:key] == DutyOptions::TariffPreference.id }
  end

  def cheapest_preference
    @cheapest_preference ||= preferences.min_by { |option| option[:evaluation][:value] } || mfn
  end

  def mfn
    @mfn ||= find { |option| option[:key] == DutyOptions::ThirdCountryTariff.id }
  end
end
