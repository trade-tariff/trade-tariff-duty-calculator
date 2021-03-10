require 'forwardable'

module Wizard
  module Steps
    class Base
      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      include ActiveModel::Model
      include ActiveModel::Attributes
      include Rails.application.routes.url_helpers

      extend ActiveModel::Callbacks
      extend Forwardable

      define_model_callbacks :initialize

      attr_reader :user_session

      def initialize(user_session, attributes = {})
        run_callbacks :initialize do
          @user_session = user_session

          clean_user_session if attributes.empty?

          super(attributes)
        end
      end

      def persisted?
        false
      end

      def initialize_dynamic_attributes
        dynamic_attribute_klass = Class.new(Wizard::Steps::Base)
        parent_klass = self
        dynamic_attributes = public_send(self.class.dynamic_attribute)

        dynamic_attribute_klass.define_singleton_method(:model_name) do
          parent_klass.model_name
        end

        define_singleton_method(:attributes) do
          dynamic_attributes.keys.map(&:downcase)
        end

        dynamic_attributes.keys.each do |dynamic_attribute|
          dynamic_attribute_klass.attribute dynamic_attribute.downcase
        end

        dynamic_answers = public_send(self.class.answer_attribute) || {}

        attributes.each do |attribute|
          dynamic_attribute_klass.validates attribute, presence: true, numericality: { only_float: true, greater_than: 0.0 }
        end

        dynamic_attribute_klass.define_method(:save) do
          user_session.public_send("#{parent_klass.class.id}=", dynamic_answers)
        end

        instance_variable_set(:@dynamic_attributes_instance, dynamic_attribute_klass.new(@user_session, dynamic_answers))

        define_singleton_method(:save) do
          @dynamic_attributes_instance.save
        end

        define_singleton_method :valid? do
          @dynamic_attributes_instance.valid?
        end

        define_singleton_method :errors do
          @dynamic_attributes_instance.errors
        end

        attributes.each do |attribute|
          define_singleton_method attribute do
            @dynamic_attributes_instance.public_send(attribute) || @user_session.dig(id, attribute)
          end
        end
      end

      def self.id
        name.split('::').last.underscore
      end

      protected

      def next_step_path(*)
        raise NotImplementedError
      end

      def previous_step_path(*)
        raise NotImplementedError
      end

      def self.dynamic_attributes(dynamic_attribute)
        answer_attribute = id

        define_singleton_method(:dynamic_attribute) do
          dynamic_attribute
        end

        define_singleton_method(:answer_attribute) do
          id
        end

        attribute dynamic_attribute
        attribute answer_attribute

        after_initialize :initialize_dynamic_attributes
      end

      private

      def clean_user_session
        @user_session.remove_step_ids(self.class::STEPS_TO_REMOVE_FROM_SESSION)
      end
    end
  end
end
