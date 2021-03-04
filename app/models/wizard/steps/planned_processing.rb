module Wizard
  module Steps
    class PlannedProcessing < Wizard::Steps::Base

    OPTIONS = [
        OpenStruct.new(id: 'without_any_processing', name: 'The goods will be sold to an end-user without any processing'),
          OpenStruct.new(id: 'annual_turnover', name: 'The importer had a total annual turnover of less than £500,000 in its most recent complete financial year'),
          OpenStruct.new(id: 'commercial_processing', name: 'The importer had a total annual turnover of less than
          £500,000 in its most recent complete financial year:', description:
              '<ul><li>the sale of food to end consumers in the UK</li><li>construction, where the processed goods
              form a permanent part of a structure that is constructed and located in NI by the importer</li> <li>direct provision of health or care services by the importer in NI</li> <li>not for profit activities in NI, where there is no subsequent sale of the processed good by the importer</li><li>the final use of animal feed on premises located in NI by the importer.</li> </ul>'.html_safe),
          OpenStruct.new(id: 'commercial_purposes', name: 'The goods will be processed for commercial purposes other than those listed above')
      ].freeze

      STEP_ID = '7'.freeze

      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      attribute :planned_processing, :string

      validates :planned_processing, presence: true

      def planned_processing
        super || user_session.planned_processing
      end

      def save
        user_session.planned_processing = planned_processing
      end

      def next_step_path(service_choice:, commodity_code:)
        # To be added on the ticket that creates the next step
      end

      def previous_step_path(service_choice:, commodity_code:)
        trader_scheme_path(service_choice: service_choice, commodity_code: commodity_code) if user_session.gb_to_ni_route?
      end
    end
  end
end
