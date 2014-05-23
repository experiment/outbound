module Gadget
  class ContactsController < ApplicationController
    before_filter :get_contact, :render_new_if_no_contact, only: :show
    after_filter :allow_in_iframes

    def show
      @process = @contact.outbound_process
    end

    def new
      @email = params.require(:email)
    end

    def create
      contact = Contact.create! do |contact|
        contact.email = params.require(:email)
        contact.source = 'gadget'
      end

      redirect_to gadget_contacts_url(email: contact.email)
    end

    private

      def get_contact
        @contact = Contact.by_email(params.require(:email)).take
      end

      def render_new_if_no_contact
        unless @contact
          new && render(:new)
        end
      end

      def allow_in_iframes
        response.headers['X-Frame-Options'] = 'ALLOWALL'
      end
  end
end
