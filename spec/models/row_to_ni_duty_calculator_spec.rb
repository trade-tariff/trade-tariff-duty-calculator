RSpec.describe RowToNiDutyCalculator do
  subject(:calculator) { described_class.new(user_session, uk_options, xi_options) }

  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_import_date,
      :with_import_destination,
      :with_country_of_origin,
      :with_trader_scheme,
      :with_certificate_of_origin,
      :with_customs_value,
      :with_measure_amount,
      :with_vat,
    )
  end

  before do
    allow(DutyOptions::Chooser).to receive(:new).and_call_original
  end

  describe '#options' do
    let(:uk_third_country_tariff_option) do
      build(
        :duty_option_result,
        :third_country_tariff,
        :uk,
        value: 0.2,
      )
    end

    let(:xi_third_country_tariff_option) do
      build(
        :duty_option_result,
        :third_country_tariff,
        :xi,
        value: 1.2,
      )
    end

    let(:uk_tariff_preference_option) do
      build(
        :duty_option_result,
        :tariff_preference,
        :uk,
        value: 100,
      )
    end
    let(:xi_tariff_preference_option) do
      build(
        :duty_option_result,
        :tariff_preference,
        :xi,
        value: 101,
      )
    end

    let(:xi_cheapest_tariff_preference_option) do
      build(
        :duty_option_result,
        :tariff_preference,
        :xi,
        value: 0.4,
      )
    end

    context 'when there are tariff preferences in both duty calculations' do
      let(:uk_options) do
        OptionCollection.new(
          [
            uk_tariff_preference_option,
            uk_third_country_tariff_option,
          ],
        )
      end
      let(:xi_options) do
        OptionCollection.new(
          [
            xi_tariff_preference_option,
            xi_third_country_tariff_option,
          ],
        )
      end

      it 'passes the uk preference option and the xi preference option' do
        calculator.options

        expect(DutyOptions::Chooser).to have_received(:new).with(uk_tariff_preference_option, xi_tariff_preference_option, user_session.total_amount)
      end
    end

    context 'when there is a tariff preference only in the uk duty calculation' do
      let(:uk_options) do
        OptionCollection.new(
          [
            uk_tariff_preference_option,
            uk_third_country_tariff_option,
          ],
        )
      end
      let(:xi_options) do
        OptionCollection.new(
          [
            xi_third_country_tariff_option,
          ],
        )
      end

      it 'passes the uk preference option and the xi mfn option' do
        calculator.options

        expect(DutyOptions::Chooser).to have_received(:new).with(
          uk_tariff_preference_option,
          xi_third_country_tariff_option,
          user_session.total_amount,
        )
      end

      it 'returns the correct options' do
        expect(calculator.options.to_a).to eq([uk_third_country_tariff_option])
      end
    end

    context 'when there is a tariff preference only in the xi duty calculation' do
      let(:uk_options) do
        OptionCollection.new(
          [
            uk_third_country_tariff_option,
          ],
        )
      end
      let(:xi_options) do
        OptionCollection.new(
          [
            xi_tariff_preference_option,
            xi_third_country_tariff_option,
          ],
        )
      end

      it 'returns the correct options' do
        expect(calculator.options.to_a).to eq([uk_third_country_tariff_option, xi_tariff_preference_option])
      end
    end

    context 'when there are multiple tariff preferences in the both duty calculations' do
      let(:uk_options) do
        OptionCollection.new(
          [
            uk_third_country_tariff_option,
            uk_tariff_preference_option,
            uk_tariff_preference_option,
          ],
        )
      end
      let(:xi_options) do
        OptionCollection.new(
          [
            xi_tariff_preference_option,
            xi_cheapest_tariff_preference_option,
            xi_third_country_tariff_option,
          ],
        )
      end

      it 'returns the correct options' do
        expect(calculator.options.to_a).to eq([uk_third_country_tariff_option, xi_cheapest_tariff_preference_option])
      end

      it 'passes the uk tariff preferences and the cheapest xi preference' do
        calculator.options

        expect(DutyOptions::Chooser).to have_received(:new).with(
          uk_tariff_preference_option,
          xi_cheapest_tariff_preference_option,
          user_session.total_amount,
        ).twice
      end
    end

    context 'when there are multiple tariff preferences in the xi duty calculation and none in the uk duty calculation' do
      let(:uk_options) do
        OptionCollection.new(
          [
            uk_third_country_tariff_option,
          ],
        )
      end
      let(:xi_options) do
        OptionCollection.new(
          [
            xi_tariff_preference_option,
            xi_cheapest_tariff_preference_option,
            xi_third_country_tariff_option,
          ],
        )
      end

      it 'returns the correct options' do
        expect(calculator.options.to_a).to eq([uk_third_country_tariff_option, xi_tariff_preference_option, xi_cheapest_tariff_preference_option])
      end
    end
  end
end
