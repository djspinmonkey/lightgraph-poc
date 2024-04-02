# frozen_string_literal: true

module Types
  class AlertingRuleType < Types::BaseObject
    field :id, ID
    field :message_destination_client_id, ID, "TODO: find a description of this field and add it here"
    field :update_interval, Integer
    field :destination, Types::AlertDestinationType, "Where to send the notification when this alert is triggered."
  end
end
