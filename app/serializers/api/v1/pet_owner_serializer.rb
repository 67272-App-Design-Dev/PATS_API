module Api::V1
  class PetOwnerSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :phone
  end
end
