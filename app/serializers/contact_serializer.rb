class ContactSerializer < ActiveModel::Serializer
  self.root = false

  # attributes
  attributes :id, :email, :start_page_viewed_at, :project_created_at
  # model methods
  attributes :contacted_at
  # serializer methods
  attributes :url, :dead, :unsubscribed

  def url
    contact_url object
  end

  def dead
    object.outbound_process.dead?
  end

  def unsubscribed
    object.outbound_process.unsubscribed?
  end
end
