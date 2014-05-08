class ContactSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, :email
  attributes :contacted_at, :opened_at, :replied_at

  def contacted_at
    object.emails.first.created_at
  end

  def opened_at
    object.emails.first.opened
  end

  def replied_at
    object.emails.first.replied_at
  end
end
