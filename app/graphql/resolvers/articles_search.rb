# frozen_string_literal: true

class Resolvers::ArticlesSearch < GraphQL::Function
  type !types[Types::ArticleType]

  argument :id, types.String
  argument :url, types.String

  def call(obj, args, context)
    Utils::ErrorHandler.new.raise_if_no_organization(context)
    Article.search_using(args[:id], args[:url], context[:organization])
  end
end
