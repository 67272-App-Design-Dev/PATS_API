class VisitPetSerializer
  include FastJsonapi::ObjectSerializer
  set_type :pet
  attributes :name, :date_of_birth
  
  attribute :animal do |object|
    object.animal.name.downcase
  end
  
  attribute :gender do |object|
    object.female ? "female" : "male"
  end

  attribute :owner do |object|
    object.owner.proper_name
  end
end