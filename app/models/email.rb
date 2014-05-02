class Email < ActiveRecord::Base
  belongs_to :contact

  # created on given day
  scope :on_date, lambda { |date| where("DATE_TRUNC('day', created_at) = ?", date) }

  scope :opened, -> { where('opened IS NOT NULL') }

  def opened!(at)
    return if opened?

    update_attributes! opened: at
  end

  def replied!(at)
    return if replied_at?

    update_attributes! replied_at: at
  end
end
