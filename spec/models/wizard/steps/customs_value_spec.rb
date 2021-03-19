require 'rails_helper'

RSpec.describe Wizard::Steps::CustomsValue do
  subject(:step) { described_class.new(user_session, attributes) }

  let(:session) { {} }
  let(:user_session) { UserSession.new(session) }

  let(:attributes) do
    ActionController::Parameters.new(
      monetary_value: '12_500',
      insurance_cost: '1_200',
      shipping_cost: '340',
    ).permit(
      :monetary_value,
      :insurance_cost,
      :shipping_cost,
    )
  end

  describe 'STEPS_TO_REMOVE_FROM_SESSION' do
    it 'returns the correct list of steps' do
      expect(described_class::STEPS_TO_REMOVE_FROM_SESSION).to eq(
        %w[],
      )
    end
  end

  describe '#validations' do
    context 'when monetary_value is blank' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '',
        ).permit(:monetary_value)
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
          monetary_value: '0',
        ).permit(:monetary_value)
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
          monetary_value: '-999',
        ).permit(:monetary_value)
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
          monetary_value: '1234',
          insurance_cost: '',
        ).permit(
          :monetary_value,
          :insurance_cost,
        )
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end
    end

    context 'when insurance_cost is a negative number' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '1234',
          insurance_cost: '-999',
        ).permit(
          :monetary_value,
          :insurance_cost,
        )
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
          monetary_value: '1234',
          insurance_cost: 'sdadsa',
        ).permit(
          :monetary_value,
          :insurance_cost,
        )
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
          monetary_value: '1234',
          insurance_cost: '1234',
          shipping_cost: '',
        ).permit(
          :monetary_value,
          :insurance_cost,
          :shipping_cost,
        )
      end

      it 'is a valid object' do
        expect(step.valid?).to be true
      end
    end

    context 'when shipping_cost is not numeric' do
      let(:attributes) do
        ActionController::Parameters.new(
          monetary_value: '1234',
          insurance_cost: '1234',
          shipping_cost: 'dwsda',
        ).permit(
          :monetary_value,
          :insurance_cost,
          :shipping_cost,
        )
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
          monetary_value: '1234',
          insurance_cost: '1234',
          shipping_cost: '-999',
        ).permit(
          :monetary_value,
          :insurance_cost,
          :shipping_cost,
        )
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

    context 'when on GB to NI route' do
      before do
        allow(user_session).to receive(:gb_to_ni_route?).and_return(true)
      end

      context 'when there is a trade defence' do
        let(:session) do
          {
            'trade_defence' => true,
          }
        end

        it 'returns trade_remedies_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            trade_remedies_path,
          )
        end
      end

      context 'when there is no trade defence, and the certificate of origin answer is NO' do
        let(:session) do
          {
            'certificate_of_origin' => 'no',
          }
        end

        it 'returns certificate_of_origin_path' do
          expect(
            step.previous_step_path,
          ).to eq(
            certificate_of_origin_path,
          )
        end
      end
    end
  end

  describe '#next_step_path' do
    include Rails.application.routes.url_helpers

    it 'returns measure_amount_path' do
      expect(
        step.next_step_path,
      ).to eq(
        measure_amount_path,
      )
    end
  end
end
