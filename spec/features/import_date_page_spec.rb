RSpec.describe 'Import Date Page', type: :feature do
  let(:commodity_code) { '0702000007' }
  let(:referred_service) { 'uk' }
  let(:tracked_attributes) do
    {
      session: session,
      commodity_code: '0702000007',
      commodity_source: 'uk',
      referred_service: 'uk',
    }
  end

  let(:session) do
    {
      'answers' => {},
      'commodity_code' => '0702000007',
      'commodity_source' => 'uk',
      'referred_service' => 'uk',
      'session_id' => 'd4c5d128a7b77649cec4508371b0ae8e',
    }
  end

  it 'does not store an invalid import date on the session' do
    visit import_date_path(commodity_code: commodity_code, referred_service: referred_service)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '2001')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session['answers'].key?(Wizard::Steps::ImportDate.id)).to be false
  end

  it 'does store a invalid import date on the session' do
    visit import_date_path(commodity_code: commodity_code, referred_service: referred_service)

    fill_in('wizard_steps_import_date[import_date(3i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(2i)]', with: '12')
    fill_in('wizard_steps_import_date[import_date(1i)]', with: '3000')

    click_on('Continue')

    expect(Capybara.current_session.driver.request.session['answers'][Wizard::Steps::ImportDate.id]).to eq('3000-12-12')
  end

  # rubocop:disable RSpec/AnyInstance
  it 'does send custom attributes to NewRelic' do
    allow(::NewRelic::Agent).to receive(:add_custom_attributes)
    # This is needed as the session_id changes per each test run
    allow_any_instance_of(ActionDispatch::Request::Session).to receive(:to_h).and_return(session)

    visit import_date_path(commodity_code: commodity_code, referred_service: referred_service)

    expect(::NewRelic::Agent).to have_received(:add_custom_attributes).with(tracked_attributes)
  end
  # rubocop:enable RSpec/AnyInstance
end
