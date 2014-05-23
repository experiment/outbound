require 'spec_helper'

describe Gadget::ContactsController do

  describe 'GET show' do
    before { Contact.create! source: 'manual', email: 'bob@test.com' }

    context 'when contact exists' do
      it 'works' do
        get :show, email: 'bob@test.com'

        expect(response).to render_template('show')

        assert_response 200
      end

      it 'sets X-Frame-Options' do
        get :show, email: 'bob@test.com'

        expect(response.headers['X-Frame-Options']).to eq 'ALLOWALL'
      end
    end

    context 'when contact does not exist' do
      it 'works' do
        get :show, email: 'bob22@test.com'

        expect(response).to render_template('new')

        assert_response 200
      end

      it 'sets X-Frame-Options' do
        get :show, email: 'bob22@test.com'

        expect(response.headers['X-Frame-Options']).to eq 'ALLOWALL'
      end
    end
  end
end
