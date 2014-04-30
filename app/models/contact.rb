class Contact < ActiveRecord::Base
  include Token

  enum source: %w(manual filofax)

  validates :source, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_many :emails

  scope :emailed, -> { joins(:emails).uniq }

  scope :by_email, lambda { |email| where('LOWER(email) = ?', email.downcase) }

  # Best guess of a contacts first name
  def first_name
    case name.split.size
      when 1
        name
      when 2
        name.split.first
      else
        name
    end
  end

  def info
    HashWithIndifferentAccess.new read_attribute(:info)
  end

  def emailed?
    emails.any?
  end
end
