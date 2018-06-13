# frozen_string_literal: true

Types::ContactType = GraphQL::ObjectType.define do
  name "Contact"
  field :id, !types.ID
  field :name, !types.String
  field :email, !types.String
  field :message, !types.String
end