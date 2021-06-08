module Wizard
  module Steps
    class Vat < Wizard::Steps::Base
      include CommodityHelper

      STEPS_TO_REMOVE_FROM_SESSION = %w[].freeze

      attribute :vat, :string

      validates :vat, presence: true

      def vat
        super || user_session.vat
      end

      def save
        user_session.vat = vat
      end

      def vat_options
        applicable_vat_options.map do |k, v|
          OpenStruct.new(id: k, name: v)
        end
      end

      def next_step_path; end

      def previous_step_path; end
    end
  end
end
