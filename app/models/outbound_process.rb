class OutboundProcess < ActiveRecord::Base
  include Workflow

  validates :contact, presence: true

  belongs_to :contact

  workflow do
    state :pending do
      event :contact, transitions_to: :contacted
    end
    state :contacted do
      event :interest, transitions_to: :interested

      event :unsubscribe, transitions_to: :unsubscribed
      event :stop, transitions_to: :dead
    end
    state :interested do # interested & follow up
      event :unsubscribe, transitions_to: :unsubscribed
      event :stop, transitions_to: :dead
    end

    state :dead # they have said no
    state :unsubscribed # requested unsubscription, never contact again

    # Store timestamps of state entries
    after_transition do |from, to, name, *args|
      self.workflow_state_timestamps = workflow_state_timestamps.merge({
        "#{to}_at" => Time.now
      })
      self.save!
    end
  end

  def active?
    !dead? && !unsubscribed?
  end
end
