module Api::V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :username, :api_key, :role, :active
  end
end
