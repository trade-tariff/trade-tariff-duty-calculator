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

      def next_step_path; end

      def previous_step_path; end
    end
  end
end
