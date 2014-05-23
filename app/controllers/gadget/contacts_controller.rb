module Gadget
  class ContactsController < ApplicationController
    before_filter :get_contact
    after_filter :allow_in_iframes

    def show
      if @contact
        @process = @contact.outbound_process
      else
        new && render(:new)
      end
    end

    def new
      @email = params.require(:email)
    end

    def create
      contact = Contact.create! do |contact|
        contact.email = params.require(:email)
        contact.source = 'gadget'
        contact.outbound_process_state = 'contacted'
      end

      redirect_to gadget_contacts_url(email: contact.email,
        host: 'https://experiment-outbound.herokuapp.com',
        authority: ENV['AUTHENTICATION_HEADER'])
    end

    private

      def get_contact
        @contact = Contact.by_email(params.require(:email)).take
      end

      def allow_in_iframes
        response.headers['X-Frame-Options'] = 'ALLOWALL'
      end
  end
end
