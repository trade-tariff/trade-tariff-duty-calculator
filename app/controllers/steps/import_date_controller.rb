module Steps
  class ImportDateController < BaseController
    def show
      @step = Steps::ImportDate.new

      persist_commodity_data
    end

    def create
      @step = Steps::ImportDate.new(permitted_params)

      validate(@step)
    end

    private

    def permitted_params
      params.require(:steps_import_date).permit(
        :'import_date(3i)',
        :'import_date(2i)',
        :'import_date(1i)',
      )
    end

    def persist_commodity_data
      user_session.commodity_code = commodity_code
      user_session.commodity_source = params[:referred_service]
      user_session.referred_service = params[:referred_service]
    end
  end
end
