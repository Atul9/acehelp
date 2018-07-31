# frozen_string_literal: true

Types::CategoryType = GraphQL::ObjectType.define do
  name "Category"
  field :id, !types.String
  field :name, !types.String

  field :articles, -> { !types[Types::ArticleType] }  do
    preload :articles
    preload_scope ->(args, context) { Article.for_organization(context[:organization]) }
    resolve ->(obj, args, context) do
      Utils::ErrorHandler.new.raise_if_no_organization(context)
      obj.articles
    end
  end
end
