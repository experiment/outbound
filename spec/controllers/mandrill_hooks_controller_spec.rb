require 'spec_helper'

describe MandrillHooksController do

  let(:contact) { Contact.create! source: 'manual', email: 'ryan@experiment.com'}
  let(:timestamp) { Time.now }
  let(:payload) { { msg: {}, ts: timestamp.to_i} }

  describe 'handle_open' do

    before do
      payload[:event] = 'open'
      payload[:msg].merge!({
        email: contact.email,
        subject: 'Open webhook',
        sender: 'oscarj@experiment.com',
        tags: [ 'outbound' ],
        ts: 1.day.ago.to_i
      })
    end

    it 'marks email as opened' do
      email = contact.emails.create! method: 'first_contact'

      post :create, mandrill_events: [ payload ].to_json

      email.reload
      expect(email.opened.to_i).to eq timestamp.to_i
    end
  end

  describe 'handle_inbound' do

    before do
      payload[:event] = 'inbound'
    end

    xit 'figure out inbound payload format' do
      post :create, mandrill_events: [ payload ].to_json
    end
  end
end
