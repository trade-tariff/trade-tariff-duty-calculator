require 'rails_helper'

RSpec.describe Wizard::Steps::CustomsValue do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }

  let(:attributes) do
    ActionController::Parameters.new(
      'monetary_value' => '12_500',
      'insurance_cost' => '1_200',
      'shipping_cost' => '340',
    ).permit!
  end

  describe '#validations' do
    context 'when monetary_value is blank' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '',
        ).permit!
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a valid monetary value', 'Enter a numeric monetary value'],
        )
      end
    end

    context 'when monetary_value is 0' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '0',
        ).permit!
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a monetary value greater than zero'],
        )
      end
    end

    context 'when monetary_value is a negative number' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '-999',
        ).permit!
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:monetary_value].to_a).to eq(
          ['Enter a monetary value greater than zero'],
        )
      end
    end

    context 'when insurance_cost is blank' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '1234',
          'insurance_cost' => '',
        ).permit!
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end
    end

    context 'when insurance_cost is a negative number' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '1234',
          'insurance_cost' => '-999',
        ).permit!
      end

      it 'is not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:insurance_cost].to_a).to eq(
          ['Enter a insurance cost value greater than or equal to zero'],
        )
      end
    end

    context 'when insurance_cost is not numeric' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '1234',
          'insurance_cost' => 'sdadsa',
        ).permit!
      end

      it 'is a not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:insurance_cost].to_a).to eq(
          ['Enter a numeric insurance cost or leave the field blank'],
        )
      end
    end

    context 'when shipping_cost is blank' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '1234',
          'insurance_cost' => '1234',
          'shipping_cost' => '',
        ).permit!
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end
    end

    context 'when shipping_cost is not numeric' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '1234',
          'insurance_cost' => '1234',
          'shipping_cost' => 'dwsda',
        ).permit!
      end

      it 'is a not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:shipping_cost].to_a).to eq(
          ['Enter a numeric shipping cost or leave the field blank'],
        )
      end
    end

    context 'when shipping_cost is a negative number' do
      let(:attributes) do
        ActionController::Parameters.new(
          'monetary_value' => '1234',
          'insurance_cost' => '1234',
          'shipping_cost' => '-999',
        ).permit!
      end

      it 'is a not a valid object' do
        expect(step.valid?).to be false
      end

      it 'adds the correct validation error messages' do
        step.valid?

        expect(step.errors.messages[:shipping_cost].to_a).to eq(
          ['Enter a shipping cost value greater than or equal to zero'],
        )
      end
    end
  end

  describe '#save' do
    it 'saves the monetary_value on to the session' do
      step.save

      expect(user_session.monetary_value).to eq '12_500'
    end

    it 'saves the insurance_cost on to the session' do
      step.save

      expect(user_session.insurance_cost).to eq '1_200'
    end

    it 'saves the shipping_cost on to the session' do
      step.save

      expect(user_session.shipping_cost).to eq '340'
    end
  end

  describe '#previous_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    it 'returns country_of_origin_path' do
      expect(
        step.previous_step_path(service_choice: service_choice, commodity_code: commodity_code),
      ).to eq(
        country_of_origin_path(service_choice: service_choice, commodity_code: commodity_code),
      )
    end
  end

  xdescribe '#next_step_path' do
    include Rails.application.routes.url_helpers

    let(:service_choice) { 'uk' }
    let(:commodity_code) { '1233455' }

    it 'must be implemented' do
    end
  end
end
