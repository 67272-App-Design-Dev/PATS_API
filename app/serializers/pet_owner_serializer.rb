class PetOwnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone
end
