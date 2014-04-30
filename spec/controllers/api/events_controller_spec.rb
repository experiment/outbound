require 'spec_helper'

describe Api::EventsController do

  describe 'POST create' do
    let!(:contact) { Contact.create! source: 'manual', email: 'ryan@experiment.com' }
    let(:timestamp) { Time.now }

    context 'project_created event' do
      context 'when email matches a contact' do
        it 'works' do
          post :create, type: 'project_created', email: 'ryan@experiment.com',
            timestamp: timestamp

          contact.reload
          expect(contact.project_created_at.to_i).to eq timestamp.to_i

          assert_response 200
        end
      end

      context 'when no contact matches' do
        it 'works' do
          post :create, type: 'project_created', email: 'bob@experiment.com',
            timestamp: timestamp

          assert_response 404
        end
      end
    end

    context 'unknown events' do
      it 'raises' do
        expect {
          post :create, type: 'george_bought_a_tux'
        }.to raise_error
      end
    end
  end

end
