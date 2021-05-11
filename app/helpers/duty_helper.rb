module DutyHelper
  def commodity_additional_code
    user_session.additional_code.values.join(', ')
  end
end
