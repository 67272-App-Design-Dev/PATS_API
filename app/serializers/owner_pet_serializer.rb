class OwnerPetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :date_of_birth, :gender, :animal_name
  set_type :pet

  attribute :visits do |object|
    object.visits.chronological.map do |visit|
      OwnerVisitSerializer.new(visit).serializable_hash
    end
  end

end