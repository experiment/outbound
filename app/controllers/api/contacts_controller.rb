module Api
  class ContactsController < ApplicationController

    def show
      contact = Contact.by_email(params[:email]).take!
      render json: contact,
        serializer: ContactSerializer,
        callback: params[:callback]
    end

    def create
      Contact.create! contact_params do |contact|
        contact.source = source_params
      end
      head :created
    end

    private

      def source_params
        params.require(:source)
      end

      def contact_params
        # Trust all params, they can only come from a source we control
        params.require(:contact).permit!
      end
  end
end
