# frozen_string_literal: true

module Types
  class OrganizationType < Types::BaseObject
    field :id, String, null: false
    field :projects, [Types::ProjectType]
  end
end
