# frozen_string_literal: true

class Mutations::UserMutations
  Create = GraphQL::Relay::Mutation.define do
    name "CreateUser"

    input_field :email, !types.String
    input_field :first_name, !types.String
    input_field :last_name, types.String
    input_field :password, !types.String
    input_field :password_confirmation, !types.String

    return_field :user, Types::UserType
    return_field :errors, types[Types::ErrorType]

    resolve ->(object, inputs, context) {
      sanitized_params = inputs.to_h.slice(*inputs.keys)
      new_user = User.new(sanitized_params)

      if new_user.save
        user = new_user
      else
        errors = Utils::ErrorHandler.new.generate_detailed_error_hash(new_user, context)
      end

      {
        user: user,
        errors: errors
      }
    }
  end
end