# frozen_string_literal: true

module Types
  class AlertType < Types::BaseObject
    field :id, String, description: "The id of the alert"

    field :name, String, description: "The name of the alert"

    field :queries, [String], description: "The query strings of any UQL queries found. This field is probably not useful as-is, since it mixes together all different kinds of alerts and queries. It is provided mostly as an example of doing some transformations of query data from the backend."
  end
end
