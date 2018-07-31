# frozen_string_literal: true

class Resolvers::CategoriesSearch < GraphQL::Function
  type !types[Types::CategoryType]

  def call(obj, args, context)
    Utils::ErrorHandler.new.raise_if_no_organization(context)
    query = Category.for_organization(context[:organization])

    args[:id].present? ? query.where(id: args[:id]) : query
  end
end
