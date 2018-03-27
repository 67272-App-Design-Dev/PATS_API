module Api::V1
  class TokenUserSerializer < ActiveModel::Serializer
    attributes :id, :username, :api_key, :role, :owner_id

    def owner_id
      object.owner ? object.owner.id : nil
    end
  end
end
