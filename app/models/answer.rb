class Answer
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  
  attr_accessor :day, :month, :year

  validates :day, presence: true
end