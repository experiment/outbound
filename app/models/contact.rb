class Contact < ActiveRecord::Base
  enum source: %w(manual)

  validates :source, presence: true
  validates :email, presence: true, uniqueness: true
end
