class AdValoremExpressionEvaluator
  def initialize(component, total_amount)
    @component = component
    @total_amount = total_amount
  end

  def call
    {
      calculation: "#{component.duty_amount}% * £#{total_amount}",
      value: value,
      formatted_value: "£#{value}",
    }
  end

  private

  def value
    total_amount / 100.0 * component.duty_amount
  end

  attr_reader :component, :total_amount
end
