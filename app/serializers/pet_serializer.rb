class PetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :date_of_birth
  
  attribute :animal do |object|
    object.animal.name.downcase
  end
  
  attribute :gender do |object|
    object.female ? "female" : "male"
  end

  attribute :current_weight do |object|
    object.visits.chronological.first.weight
  end

  attribute :owner do |object|
    PetOwnerSerializer.new(object.owner).serializable_hash
  end

  attribute :visits do |object|
    object.visits.chronological.map do |visit|
      PetVisitSerializer.new(visit).serializable_hash
    end
  end


end
