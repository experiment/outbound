require 'spec_helper'

describe Api::Contacts::ProcessesController do

  describe 'POST event' do
    before do
      @contact = Contact.create! source: 'filofax', email: 'bob@test.com'
      @contact.outbound_process.update_attributes! workflow_state: 'contacted'
    end

    context 'a contacted contact' do
      it 'stops on stop' do
        post :event, contact_id: @contact.id, event: 'stop'

        process = @contact.reload.outbound_process
        expect(process).to be_dead

        assert_response 200
      end

      it 'interested on interest' do
        post :event, contact_id: @contact.id, event: 'interest'

        process = @contact.reload.outbound_process
        expect(process).to be_interested

        assert_response 200
      end

      it 'unsubscribes on unsubscribe' do
        post :event, contact_id: @contact.id, event: 'unsubscribe'

        process = @contact.reload.outbound_process
        expect(process).to be_unsubscribed

        assert_response 200
      end
    end
  end

end
