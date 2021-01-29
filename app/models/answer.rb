class Answer
  attr_accessor :day, :month, :year

  validate  :dob_format, unless: -> { dob.present? }
end