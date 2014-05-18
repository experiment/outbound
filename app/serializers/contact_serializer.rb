class ContactSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, :email, :start_page_viewed_at, :project_created_at
  attributes :contacted_at

  def contacted_at
    return nil unless object.emails.any?

    object.emails.first.created_at
  end
end
