class PetOwnerSerializer
  include FastJsonapi::ObjectSerializer
  set_type :owner
  attributes :name, :zip, :email
  attribute :phone do |object|
    ActionController::Base.helpers.number_to_phone(object.phone)
  end 

end