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
end
