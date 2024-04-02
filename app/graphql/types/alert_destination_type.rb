# frozen_string_literal: true
#
# TODO: Make subtypes for different types of destination (slack, webhook, etc)

module Types
  class AlertDestinationType < Types::BaseObject
    field :id, ID
    field :name, String, "The name of this alert destination"
    field :type, String, "The type of destination, such as 'slack', 'webhook', etc"
    field :channel, String, "The slack channel to send the alert to"
    field :scope, String, "The slack scope to use when sending this alert to slack"
    field :url, String, "The url to send the alert to"
    field :template, String, "The template for the request body when sending this alert to a web hook"
  end
end
