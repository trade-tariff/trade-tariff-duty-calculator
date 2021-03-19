RSpec.describe Api::DutyExpression do
  it_behaves_like 'a resource that has attributes', base: '0.00 %',
                                                    formatted_base: '<span>0.00</span> %'
end
