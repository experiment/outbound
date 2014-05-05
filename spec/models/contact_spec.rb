require 'spec_helper'

describe Contact do
  describe '#emailed?' do
    let(:contact) { create :contact }

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
end
