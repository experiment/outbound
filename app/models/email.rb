class Email < ActiveRecord::Base
  belongs_to :contact

  # created on given day
  scope :on_date, lambda { |date| where("DATE_TRUNC('day', created_at) = ?", date) }

  def opened!(at)
    update_attributes! opened: at
  end
end
