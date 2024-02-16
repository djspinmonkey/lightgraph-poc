# frozen_string_literal: true

module Types
  class OrganizationType < Types::BaseObject
    field :id, String, null: false, description: "The ID of the organization."

    field :projects, [Types::ProjectType], description: "Fetches data for all projects defined for this organization."

    field :project, Types::ProjectType, description: "Fetches data related to a specific project." do
      argument :id, String, required: true, description: "The ID of the project (which is a string)."
    end
  end
end
