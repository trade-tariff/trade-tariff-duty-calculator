class Step
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Rails.application.routes.url_helpers

  attribute :step
  attribute :next_step
  attribute :answer

  def update_answer(new_answer)
    raise NotImplementedError
  end

  def persisted?
    false
  end
end

class CountryOfOrigin < Step
end

class ImportDate < Step
end

class StepList
  include Enumerable

  attr_reader :first_step

  def initialize(first_step)
    @first_step = first_step
  end

  def each
    step = first_step

    yield first_step

    while step.next_step.present?
      step = step.next_step
      yield step
    end
  end

  def to_json(*_args)
    {
      steps: map { |step| { step: step.step, answer: step.answer } },
    }
  end

  def self.build(session)
    all_steps = session[:steps].map do |step_config|
      step_model = step_config[:step].classify.to_s.constantize
      step_model.new(step_config)
    end

    all_steps.each_cons(2) do |step, next_step|
      step.next_step = next_step
    end

    new(all_steps.first)
  end
end

session = {
  steps: [
    { step: 'import_date', answer: '2021-01-01' },
    { step: 'country_of_origin', answer: 'GB' },
  ],
}

list = StepList.build(session)
list.to_json
