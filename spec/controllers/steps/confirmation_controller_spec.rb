RSpec.describe Steps::ConfirmationController, :user_session do
  let(:user_session) do
    build(
      :user_session,
      :with_commodity_information,
      :with_import_date,
      :with_import_destination,
      :with_country_of_origin,
      :with_trader_scheme,
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

    it 'assigns the correct step' do
      response
      expect(assigns[:step]).to be_a(Steps::Confirmation)
    end

    it 'assigns the correct decorated_step' do
      response
      expect(assigns[:decorated_step]).to be_a(ConfirmationDecorator)
    end

    it 'contains the summary of all the previously given answers' do
      expect(response.body).to include(expected_content)
    end

    it 'contains the links that allow users to go back and change their answers' do
      expected_links.each do |link|
        expect(response.body).to include(link)
      end
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template('confirmation/show') }
  end
end
