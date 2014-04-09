class Contact < ActiveRecord::Base
  enum source: %w(manual)

  validates :source, presence: true
end
