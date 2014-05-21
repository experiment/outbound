require 'spec_helper'

describe OutboundProcess do
  before do
    @contact = Contact.create! source: 'filofax', email: 'bob@test.com'
    @process = @contact.outbound_process
    @process.update_attributes! workflow_state: 'contacted'
  end

  describe 'on_interested_entry' do
    it 'sends a follow up email' do
      expect {
        @process.interest!
      }.to change(ActionMailer::Base.deliveries, :size).by(1)

      message = ActionMailer::Base.deliveries.last
      expect(message._mailer_method).to eq :interested_first_follow_up
      expect(message._recipient_contact_id).to eq @contact.id
      expect(message.body).to include("start/#{@contact.token}")
    end
  end
end
