# frozen_string_literal: true

class Order
  module StateMachine
    extend ActiveSupport::Concern

    included do
      include AASM

      # enum :status, { pending: 0, delivered: 1, cancelled: 2 }
      aasm column: :state, timestamps: true do
        state :pending, initial: true
        state :ordered
        state :delivered
        state :withdrawn
        state :cancelled

        event :order do
          transitions from: :pending, to: :ordered
        end

        event :deliver do
          transitions from: :ordered, to: :delivered
        end

        event :withdraw do
          transitions from: :delivered, to: :withdrawn
        end

        event :cancel do
          transitions from: %i[ordered delivered], to: :cancelled
        end
      end
    end
  end
end
