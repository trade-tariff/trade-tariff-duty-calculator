module Wizard
  module Steps
    class MeasureAmount
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      include ActiveModel::Model
      include CommodityHelper
      include Rails.application.routes.url_helpers

      attr_reader :applicable_measure_units

      validates_each :answers do |record, _attr, _value|
        validation_messages = I18n.t('activemodel.errors.models.wizard/steps/measure_amount.attributes.answers')

        record.applicable_measure_units.each do |key, values|
          key = key.downcase
          value = record.public_send(key.downcase)

          record.errors.add(key, "#{validation_messages[:blank]} #{values['unit_hint']}") if value.blank?

          value = Float(value)

          record.errors.add(key, "#{validation_messages[:greater_than]} #{values['unit_hint']}") unless value.positive?
        rescue ArgumentError, TypeError
          record.errors.add(key, "#{validation_messages[:not_a_number]} #{values['unit_hint']}")
        end
      end

      def initialize(user_session, attributes)
        @user_session = user_session
        @attributes = attributes
        @answers = attributes['measure_amount']
        @applicable_measure_units = attributes['applicable_measure_units']
        @applicable_measure_units.each do |key, _values|
          key = key.downcase

          define_singleton_method(key) do
            instance_variable_get("@#{key}") || user_session.measure_amount[key]
          end

          define_singleton_method("#{key}=") do |value|
            instance_variable_set("@#{key}", value)
          end
        end

        @answers.each do |key, value|
          public_send("#{key}=", value)
        end
      end

      def save
        user_session.measure_amount = answers if answers.present?
      end

      def next_step_path
        return additional_codes_path(applicable_additional_codes.keys.first) if applicable_additional_codes.present?

        confirm_path
      end

      def previous_step_path
        customs_value_path
      end

      def self.id
        name.split('::').last.underscore
      end

      private

      attr_reader :user_session, :answers, :attributes
    end
  end
end
