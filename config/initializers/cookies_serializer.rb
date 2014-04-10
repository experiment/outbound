# Be sure to restart your server when you modify this file.

# Use marshal serializer so Warden::GitHub::User can be deserialized
# correctly
# See atmos/warden-github#38
Rails.application.config.action_dispatch.cookies_serializer = :marshal
