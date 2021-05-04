module Wizard
  module Steps
    class Base
      include ActiveModel::Model
      include ActiveModel::Attributes
      include Rails.application.routes.url_helpers

      attr_reader :user_session

      def initialize(user_session, attributes = {})
        @user_session = user_session

        clean_user_session if attributes.empty?

        super(attributes)
      end

      def self.id
        name.split('::').last.underscore
      end

      protected

      def next_step_path
        raise NotImplementedError
      end

      def previous_step_path
        raise NotImplementedError
      end

      def filtered_commodity(filter: default_filter)
        query = default_query.merge(filter)

        Api::Commodity.build(
          user_session.commodity_source,
          user_session.commodity_code,
          query,
        )
      end

      def default_query
        { 'as_of' => user_session.import_date.iso8601 }
      end

      def default_filter
        { 'filter[geographical_area_id]' => user_session.country_of_origin }
      end

      def applicable_additional_codes
        @applicable_additional_codes ||= filtered_commodity.applicable_additional_codes
      end

      private

      def clean_user_session
        @user_session.remove_step_ids(self.class::STEPS_TO_REMOVE_FROM_SESSION)
      end
    end
  end
end
