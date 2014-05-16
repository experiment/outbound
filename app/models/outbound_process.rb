class OutboundProcess < ActiveRecord::Base
  include Workflow

  validates :contact, presence: true

  belongs_to :contact

  workflow do
    state :pending do
      event :contact, transitions_to: :contacted
    end
    state :contacted do
      event :unsubscribe, transitions_to: :unsubscribed
      event :stop, transitions_to: :dead
    end

    state :dead # they have said no
    state :unsubscribed # requested unsubscription, never contact again
  end
end
