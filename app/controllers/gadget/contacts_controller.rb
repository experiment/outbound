module Gadget
  class ContactsController < ApplicationController
    before_filter :get_contact, :show_create_if_no_contact
    after_filter :allow_in_iframes

    def show
      @process = @contact.outbound_process
    end

    private

      def get_contact
        @contact = Contact.by_email(params.require(:email)).take
      end

      def show_create_if_no_contact
        unless @contact
          render text: 'no contact'
        end
      end

      def allow_in_iframes
        response.headers['X-Frame-Options'] = 'ALLOWALL'
      end
  end
end
