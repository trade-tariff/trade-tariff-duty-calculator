class DutyOptionResult
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :type
  attribute :category
  attribute :footnote
  attribute :measure_sid
  attribute :priority
  attribute :source
  attribute :value
  attribute :values
  attribute :warning_text
  attribute :order_number
  attribute :geographical_area_description

  def footnote
    (super + footnote_suffix).html_safe
  end

  def footnote_suffix
    @footnote_suffix.presence || ''
  end

  def footnote_suffix=(suffix)
    return if @footnote_suffix

    @footnote_suffix = suffix
  end
end
