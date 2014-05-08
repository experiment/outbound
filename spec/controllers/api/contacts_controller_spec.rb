require 'spec_helper'

describe Api::ContactsController do

  describe 'GET show' do
    before { Contact.create! source: 'manual', email: 'bob@test.com' }

    context 'when contact exists' do
      it 'returns the contact as JSON' do
        get :show, id: 'bob@test.com'

        expect(response.content_type).to eq 'application/json'

        assert_response 200
      end
    end

    context "when contact doesn't exist" do
      it 'raises ActiveRecord::RecordNotFound' do
        expect {
          get :show, id: 'joe@test.com'
        }.to raise_error
      end
    end
  end

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
