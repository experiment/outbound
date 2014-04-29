require 'spec_helper'

describe Api::ContactsController do

  describe 'POST create' do
    let(:contact_params) do
      { email: 'bob@test.com', name: 'Bob Smith', info: { journal: 'Title' } }
    end

    it 'creates a contact & returns 200' do
      expect {
        post :create, source: 'manual', contact: contact_params
      }.to change(Contact, :count).by(1)

      contact = Contact.last
      expect(contact.email).to eq 'bob@test.com'
      expect(contact.name).to eq 'Bob Smith'
      expect(contact.source).to eq 'manual'
      expect(contact.info).to eq({ 'journal' => 'Title' })

      assert_response 201
    end

    context 'when contact already exists' do
      before { Contact.create! source: 'manual', email: 'bob@test.com' }

      it 'works' do
        expect {
          post :create, source: 'manual', contact: contact_params
        }.to raise_error
      end
    end
  end
end
