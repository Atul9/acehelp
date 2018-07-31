# frozen_string_literal: true

class Resolvers::TicketsSearch < GraphQL::Function
  type !types[Types::TicketType]

  argument :id, types.String

  def call(obj, args, context)
    Utils::ErrorHandler.new.raise_if_no_organization(context)
    query = Ticket.for_organization(context[:organization])

    args[:id].present? ? query.where(id: args[:id]) : query
  end
end
