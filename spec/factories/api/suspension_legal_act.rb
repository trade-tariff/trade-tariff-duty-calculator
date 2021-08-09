FactoryBot.define do
  factory :suspension_legal_act, class: 'Api::SuspensionLegalAct' do
    id {}
    validity_end_date {}
    validity_start_date {}
    regulation_code {}
    regulation_url {}
  end
end
