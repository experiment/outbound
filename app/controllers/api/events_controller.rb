module Api
  class EventsController < ApplicationController

    def create
      case type
      when 'project_created'
        if (contact = Contact.by_email(project_created_data[:email]).take)
          # Mark contact as having created a project
          contact.project_created! project_created_data[:timestamp]
          head :ok
        else
          head :not_found
        end
      when 'start_page_viewed'
        contact = Contact.find_by_token(start_page_viewed_data[:token])
        contact.start_page_viewed! start_page_viewed_data[:timestamp]
        head :ok
      else
        raise "Unknown event type: #{type}"
      end
    end

    private

      def type
        params.require(:type)
      end

      def project_created_data
        {
          email: params.require(:email),
          timestamp: Time.parse(params.require(:timestamp))
        }
      end

      def start_page_viewed_data
        {
          token: params.require(:token),
          timestamp: Time.parse(params.require(:timestamp))
        }
      end
  end
end
