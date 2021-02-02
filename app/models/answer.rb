class Answer
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  
  attr_accessor :date_of_birth

  validates :date_of_birth, presence: true
end