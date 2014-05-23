require 'spec_helper'

describe Contact do
  let(:contact) { create :contact }

  describe '#emailed?' do
    context 'when the contact has associated emails' do
      before { contact.emails.create }

      it 'returns true' do
        expect(contact.emailed?).to be true
      end
    end

    context 'when the contact has no associated emails' do
      it 'returns false' do
        expect(contact.emailed?).to be false
      end
    end

    context 'for out outbound contacts' do
      let(:contact) { build :contact, source: 'old_outbound' }

      it 'returns true' do
        expect(contact.emailed?).to be true
      end
    end
  end

  describe '#first_name' do
    context 'when name is one word' do
      before { contact.name = 'Emily' }

      it 'returns the name' do
        expect(contact.first_name).to eq 'Emily'
      end
    end

    context 'when name is two words' do
      before { contact.name = 'Emily Smith' }

      it 'returns the first word' do
        expect(contact.first_name).to eq 'Emily'
      end
    end

    context 'when name is two words and an initial' do
      before { contact.name = 'Emily B. Smith' }

      it 'returns the first word' do
        expect(contact.first_name).to eq 'Emily'
      end
    end

    context 'otherwise' do
      before { contact.name = 'Dr Emily Boom' }

      it 'returns the name' do
        expect(contact.first_name).to eq 'Dr Emily Boom'
      end
    end
  end
end
