FactoryBot.define do
  factory :rules_of_origin_scheme, class: 'Api::RulesOfOriginScheme' do
    scheme_code { 'albania' }
    title { 'UK-Albania partnership Trade and Cooperation Agreement' }
    countries { %w[AL] }
    footnote { nil }
    fta_intro { '### UK-Albania partnership trade and cooperation agreement\n\n' }
    introductory_notes { '### Note 1:\n\nThe list sets out the conditions required for all products to be considered as sufficiently worked' }
    unilateral { nil }
    rules { [] }
    links { [] }
    proofs { [] }
  end
end
