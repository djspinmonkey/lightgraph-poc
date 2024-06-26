# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :organization, Types::OrganizationType, description: "Fetches data related to a specific customer organization." do
      argument :id, String, required: true, description: "The ID of the organization (which is a string)."
    end
    def organization(id:) = Organization.new(id)

    field :actor, Types::ActorType, description: "Information about the requestor and this test server."
    def actor = "unused" # TODO: There's probably a better way to do this.
  end
end
