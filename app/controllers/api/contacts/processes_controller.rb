module Api
  module Contacts
    class ProcessesController < ApplicationController
      before_filter :get_contact, :get_process

      def event
        head :ok
      end

      private

        def get_contact
          @contact = Contact.find contact_params
        end

        def get_process
          @process = @contact.outbound_process ||
            raise(ActiveRecord::RecordNotFound)
        end

        def contact_params
          params.require(:contact_id)
        end
    end
  end
end
