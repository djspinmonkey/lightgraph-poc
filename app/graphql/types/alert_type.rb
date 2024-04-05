# frozen_string_literal: true

module Types
  class AlertType < Types::BaseObject
    field :id, ID, description: "The id of the alert"

    field :name, String, description: "The name of the alert"

    field :description, String, description: "A human readable description of the alert"

    field :labels, [String], description: "A set of labels applied to this alert"

    field :enable_no_data_alert, Boolean, "Indicates whether the alert will trigger if there is no data"

    field :no_data_duration, Int, "How long in ms there can be no data before the alert triggers"

    field :operand, String, "The operand of the alert expression"

    field :warning_threshold, Float, "Values higher than this threshold put the alert into the warning state after a certain duration"

    field :warning_threshold_duration, Int, "How many ms the values must be above the warning threshold before the alert enters the warning state"

    field :critical_threshold, Float, "Values higher than this threshold put the alert into the critical state after a certain duration"

    field :critical_threshold_duration, Int, "How many ms the values must be above the critical threshold before the alert enters the critical state"

    field :is_multi_alert, Boolean, "Indicates whether this alert is a multi-alert"

    field :all_queries, [String], "The query strings of any UQL queries found. This field may not be particularly useful as-is, since it mixes together all different kinds of alerts and queries. It is provided mostly as an example of doing some transformations of query data from the backend."

    field :alerting_rules, [Types::AlertingRuleType], "The set of rules defining how to send notifications when this alert is triggered"

    field :destinations, [Types::AlertDestinationType], "The set of destinations this alert will be sent to when triggered (as defined by the alerting rules). This is a convenience field to avoid having to go through the alerting rules if all you care about is the destination."

    field :snoozed, Boolean, "Indicates whether this alert is currenttly snoozed", method: :snoozed?

    field :snooze_ends_at, GraphQL::Types::BigInt, "MICROSECONDS since the epoch when the current snooze ends (or nil if not currently snoozed"
  end
end
