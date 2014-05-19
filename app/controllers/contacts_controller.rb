class ContactsController < ApplicationController
  before_filter :get_contact

  def show
    @process = @contact.outbound_process
  end

  private

    def get_contact
      @contact = Contact.find params.require(:id)
    end
end
