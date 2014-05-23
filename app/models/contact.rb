class Contact < ActiveRecord::Base
  include Token

  enum source: %w(manual filofax old_outbound gadget)

  validates :source, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  attr_accessor :outbound_process_state
  after_create do
    create_outbound_process workflow_state: outbound_process_state
  end

  has_many :emails
  has_one :outbound_process

  scope :emailed, -> { joins(:emails).uniq }

  scope :by_email, lambda { |email| where('LOWER(email) = ?', email.downcase) }

  # Best guess of a contacts first name
  def first_name
    case name.split.size
      when 1
        name
      when 2
        name.split.first
      when 3
        split = name.split
        if split[1].sub(/\./,'').size == 1
          split.first
        else
          name
        end
      else
        name
    end
  end

  def info
    HashWithIndifferentAccess.new read_attribute(:info)
  end

  def emailed?
    # If old outbound contact, was emailed from old system
    return true if old_outbound?

    emails.any?
  end

  def contacted_at
    return nil unless emails.any?

    emails.first.created_at
  end

  def project_created!(at)
    update_attributes! project_created_at: at
  end

  def start_page_viewed!(at)
    update_attributes! start_page_viewed_at: at
  end
end
