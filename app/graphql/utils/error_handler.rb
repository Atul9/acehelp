# frozen_string_literal: true

class Utils::ErrorHandler
  def generate_graphql_error_with_root(message, path:, extensions: {})
    path = [path] if path.is_a?(String)
    {
        data: nil,
        errors: [
            {
                message: message,
                path: path,
                extensions: extensions
            }
        ]
    }
  end

  def error(message, context, attributes: [])
    [
      {
        message: message,
        path: [context.key] + attributes
      }
    ]
  end

  def detailed_error(object, context, general_message: nil)
    if object.respond_to?(:errors) && object.errors.present?
      object.errors.map do |attribute, message|
        attribute = attribute.to_s
        {
          path: [context.key, "attribute", attribute],
          message: general_message || "#{attribute} #{message}"
        }
      end
    end
  end

  def raise_gql_error(message = nil)
    raise GraphQL::ExecutionError, (message || "Can't continue with this query")
  end

  def raise_if_no_organization(context)
    unless context[:organization]
      raise_gql_error "No Organization found"
    end
  end

end
