RSpec.describe 'errors/not_found', type: :view do
  let(:user_session) { build(:user_session, :with_commodity_information) }

  it 'renders a link to the import_date_path' do
    render template: 'errors/not_found', locals: { user_session: user_session }

    expected_path = import_date_path(referred_service: user_session.referred_service, commodity_code: user_session.commodity_code)

    expect(rendered).to include(expected_path)
  end
end
