class OwnerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :street, :city, :state, :zip, :email
  attribute :phone do |object|
    ActionController::Base.helpers.number_to_phone(object.phone)
  end 
  # has_many :pets 
  # has_many :visits, through: :pets
  # belongs_to :user

  attribute :active_pets do |object|
    object.pets.active.map do |pet|
      OwnerPetSerializer.new(pet).serializable_hash
    end
  end

  attribute :inactive_pets do |object|
    object.pets.inactive.map do |pet|
      OwnerPetSerializer.new(pet).serializable_hash
    end
  end

end
