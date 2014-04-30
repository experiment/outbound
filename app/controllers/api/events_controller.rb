module Api
  class EventsController < ApplicationController

    def create
      case type
      when 'project_created'
        if (contact = Contact.by_email(project_created_data[:email]).take)
          # TODO, mark contact as having created a project
          head :ok
        else
          head :not_found
        end
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
  end
end
