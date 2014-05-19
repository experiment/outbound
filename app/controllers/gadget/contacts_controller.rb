module Gadget
  class ContactsController < ApplicationController
    before_filter :get_contact
    after_filter :allow_in_iframes

    def show
      render text: @contact.name
    end

    private

      def get_contact
        @contact = Contact.by_email(params.require(:email)).take!
      end

      def allow_in_iframes
        response.headers['X-Frame-Options'] = 'ALLOWALL'
      end
  end
end
