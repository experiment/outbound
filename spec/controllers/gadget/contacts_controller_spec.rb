require 'spec_helper'

describe Gadget::ContactsController do

  describe 'GET show' do
    before { Contact.create! source: 'manual', email: 'bob@test.com' }

    it 'sets X-Frame-Options' do
      get :show, email: 'bob@test.com'

      expect(response.headers['X-Frame-Options']).to eq 'ALLOWALL'
    end

    context 'when contact exists' do
      it 'works' do
        get :show, email: 'bob@test.com'

        assert_response 200
      end
    end
  end

end
