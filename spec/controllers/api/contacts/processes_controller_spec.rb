require 'spec_helper'

describe Api::Contacts::ProcessesController do

  describe 'POST event' do
    before do
      @contact = Contact.create! source: 'filofax', email: 'bob@test.com'
      @contact.create_outbound_process!
    end

    it 'works' do
      post :event, contact_id: @contact.id

      assert_response 200
    end
  end

end
