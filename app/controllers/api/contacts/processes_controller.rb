module Api
  module Contacts
    class ProcessesController < ApplicationController
      before_filter :get_contact, :get_process

      def event
        case event_params
          when 'interest_auto'
            @process.interest!
          when 'interest_manual'
            @process.interest_manual!

          when 'stop'
            @process.stop!
          when 'unsubscribe'
            @process.unsubscribe!
        end

        render json: @contact,
          serializer: ContactSerializer,
          callback: params[:callback]
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

        def event_params
          params.require(:event)
        end
    end
  end
end
