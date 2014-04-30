require 'spec_helper'

describe Api::EventsController do

  describe 'POST create' do
    let!(:contact) { Contact.create! source: 'manual', email: 'ryan@experiment.com' }

    context 'project_created event' do
      context 'when email matches a contact' do
        it 'works' do
          post :create, type: 'project_created', email: 'ryan@experiment.com',
            timestamp: Time.now

          contact.reload
          # TODO, check contact has been marked as having created a project

          assert_response 200
        end
      end

      context 'when no contact matches' do
        it 'works' do
          post :create, type: 'project_created', email: 'bob@experiment.com',
            timestamp: Time.now

          contact.reload

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
