class Email < ActiveRecord::Base
  belongs_to :contact

  def opened!(at)
    update_attributes! opened: at
  end
end
