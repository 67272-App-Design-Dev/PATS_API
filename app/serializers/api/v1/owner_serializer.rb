module Api::V1
  class OwnerSerializer < ActiveModel::Serializer
    attributes :id, :name, :street, :city, :state, :zip, :email, :phone, :username, :active_pets, :inactive_pets

    def active_pets
      object.pets.active.alphabetical.map do |pet|
        OwnerPetSerializer.new(pet)
      end
    end

    def inactive_pets
      object.pets.inactive.alphabetical.map do |pet|
        OwnerPetSerializer.new(pet)
      end
    end
  end
end
