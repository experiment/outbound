class OutboundProcess < ActiveRecord::Base
  include Workflow

  validates :contact, presence: true

  belongs_to :contact

  workflow do
    state :pending do
      event :contact, transitions_to: :contacted
    end
    state :contacted
  end
end
