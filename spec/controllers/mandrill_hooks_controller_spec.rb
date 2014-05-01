require 'spec_helper'

describe MandrillHooksController do

    let(:timestamp) { Time.now }
    let(:payload) do
      {
        event: 'open',
        msg: {
          ts: 1.day.ago.to_i,
          subject: 'Open webhook',
          sender: 'oscarj@experiment.com',
          tags: [ 'outbound' ]
        },
        ts: timestamp.to_i
      }
    end

  describe 'handle_open' do
    let(:contact) { Contact.create! source: 'manual', email: 'ryan@experiment.com'}

    it 'marks email as opened' do
      payload[:msg][:email] = contact.email
      email = contact.emails.create! method: 'first_contact'

      post :create, mandrill_events: [ payload ].to_json

      email.reload
      expect(email.opened.to_i).to eq timestamp.to_i
    end
  end

  describe 'handle_inbound' do
    pending 'add specs'
  end
end
