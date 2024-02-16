# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :id, String, null: false, description: "The ID of the project."

    field :name, String, null: false, description: "The name of the project (which seems to always be the same as the ID)"

    field :alerts, [Types::AlertType], description: "Fetches data for all alerts defined on this project. It is not recommended to fetch all alerts for all projects, since each alert is a separate request to the backend, and that ends up being quite a few requests. Fetching all alerts for a single project is fine."

    field :alert, Types::AlertType, description: "Fetches data related to a specific alert." do
      argument :id, String, required: true, description: "The ID of the alert (which is a string)."
    end
  end
end
