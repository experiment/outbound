require 'spec_helper'

describe Api::Contacts::ProcessesController do

  describe 'POST event' do
    before do
      @contact = Contact.create! source: 'filofax', email: 'bob@test.com'
      @contact.outbound_process.update_attributes! workflow_state: 'contacted'
    end

    context 'a contacted contact' do
      it 'stops on stop' do
        get :event, contact_id: @contact.id, event: 'stop'

        process = @contact.reload.outbound_process
        expect(process).to be_dead

        expect(response.content_type).to eq 'application/json'
        assert_response 200
      end

      it 'interested on interest' do
        get :event, contact_id: @contact.id, event: 'interest'

        process = @contact.reload.outbound_process
        expect(process).to be_interested

        expect(response.content_type).to eq 'application/json'
        assert_response 200
      end

      it 'unsubscribes on unsubscribe' do
        get :event, contact_id: @contact.id, event: 'unsubscribe'

        process = @contact.reload.outbound_process
        expect(process).to be_unsubscribed

        expect(response.content_type).to eq 'application/json'
        assert_response 200
      end
    end
  end

end
