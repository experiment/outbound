class Contact < ActiveRecord::Base
  enum source: %w(manual)

  validates :source, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :emails

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

end
