RSpec.describe Steps::ConfirmationController, :user_session do
  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_import_date,
      :with_import_destination,
      :with_country_of_origin,
      :without_trader_scheme,
      :with_small_turnover,
      :with_planned_processing,
      :with_certificate_of_origin,
      :with_meursing_additional_code,
      :with_customs_value,
      :with_measure_amount,
      :with_vat,
    )
  end

  describe 'GET #show' do
    render_views

    subject(:response) { get :show }

    let(:expected_content) { File.read('spec/fixtures/confirmation_page.html').chomp }

    let(:expected_links) do
      [
        'https://dev.trade-tariff.service.gov.uk/sections',
        '/duty-calculator/uk/0702000007/import-date',
        '/duty-calculator/import-destination',
        '/duty-calculator/country-of-origin',
        '/duty-calculator/trader-scheme',
        '/duty-calculator/certificate-of-origin',
        '/duty-calculator/meursing-additional-codes',
        '/duty-calculator/customs-value',
        '/duty-calculator/measure-amount',
        '/duty-calculator/vat',
      ]
    end

    it 'assigns the correct decorated_step' do
      response
      expect(assigns[:decorated_step]).to be_a(ConfirmationDecorator)
    end

    it { expect(response.body).to include(expected_content) }
    it { expected_links.each { |link| expect(response.body).to include(link) } }
    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('confirmation/show') }
  end
end
