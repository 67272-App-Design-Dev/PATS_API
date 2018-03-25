class OwnerSerializer < ActiveModel::Serializer
  # attributes :id, :name, :street, :city, :state, :zip, :email, :phone
  # attributes :id, :name, :street, :city, :state, :zip, :email, :phone, :username, :active_pets, :inactive_pets, :visits
  attributes :id, :name, :street, :city, :state, :zip, :email, :phone, :username, :active_pets, :inactive_pets

  # Relationships
  # has_many :pets 
  # has_many :visits, through: :pets
  # belongs_to :user

  def active_pets
    object.pets.active.alphabetical.map do |pet|
      PetSerializer.new(pet)
    end
  end

  def inactive_pets
    object.pets.inactive.alphabetical.map do |pet|
      PetSerializer.new(pet)
    end
  end

  # def visits
  #   object.visits.chronological.map do |visit|
  #     VisitSerializer.new(visit)
  #   end
  # end
end
