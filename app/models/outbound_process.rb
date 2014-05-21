class OutboundProcess < ActiveRecord::Base
  include Workflow

  validates :contact, presence: true

  belongs_to :contact

  workflow do
    state :pending do
      event :contact, transitions_to: :contacted
    end
    state :contacted do
      event :called, transitions_to: :been_called
      event :interest, transitions_to: :interested
      event :interest_manual, transitions_to: :interested_manual

      event :unsubscribe, transitions_to: :unsubscribed
      event :stop, transitions_to: :dead
    end
    state :been_called do
      event :interest, transitions_to: :interested
      event :interest_manual, transitions_to: :interested_manual

      event :unsubscribe, transitions_to: :unsubscribed
      event :stop, transitions_to: :dead
    end
    state :interested do # interested & follow up
      event :unsubscribe, transitions_to: :unsubscribed
      event :stop, transitions_to: :dead
    end
    state :interested_manual do # interested & no follow up
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

  ## Transition methods, called as a result of a state change
  concerning :Transitions do

    def on_interested_entry(new_state, event, *args)
      FollowUps.interested_first_follow_up(contact.id).deliver
    end

  end

  def active?
    !dead? && !unsubscribed?
  end
end
