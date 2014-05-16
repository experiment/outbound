class OutboundProcess < ActiveRecord::Base
  include Workflow

  validates :contact, presence: true

  belongs_to :contact

  workflow do
    state :pending
  end
end
