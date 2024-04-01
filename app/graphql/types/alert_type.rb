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

    field :queries, [String], description: "The query strings of any UQL queries found. This field may not be particularly useful as-is, since it mixes together all different kinds of alerts and queries. It is provided mostly as an example of doing some transformations of query data from the backend."
  end
end
