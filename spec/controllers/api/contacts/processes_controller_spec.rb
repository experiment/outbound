require 'spec_helper'

describe Api::Contacts::ProcessesController do

  describe 'POST event' do
    before do
      @contact = Contact.create! source: 'filofax', email: 'bob@test.com'
      @contact.outbound_process.update_attributes! workflow_state: 'contacted'
    end

    context 'a contacted contact' do
      it 'punt on punt' do
        get :event, contact_id: @contact.id, event: 'punt'

        process = @contact.reload.outbound_process
        expect(process).to be_been_punt

        expect(response.content_type).to eq 'application/json'
        assert_response 200
      end

      it 'been_called on called' do
        get :event, contact_id: @contact.id, event: 'called'

        process = @contact.reload.outbound_process
        expect(process).to be_been_called

        expect(response.content_type).to eq 'application/json'
        assert_response 200
      end

      it 'interested on interest' do
        get :event, contact_id: @contact.id, event: 'interest_auto'

        process = @contact.reload.outbound_process
        expect(process).to be_interested

        expect(response.content_type).to eq 'application/json'
        assert_response 200
      end

      it 'interested_manual on interest_manual' do
        get :event, contact_id: @contact.id, event: 'interest_manual'

        process = @contact.reload.outbound_process
        expect(process).to be_interested_manual

        expect(response.content_type).to eq 'application/json'
        assert_response 200
      end

      it 'stops on stop' do
        get :event, contact_id: @contact.id, event: 'stop'

        process = @contact.reload.outbound_process
        expect(process).to be_dead

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
