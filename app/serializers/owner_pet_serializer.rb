class OwnerPetSerializer < ActiveModel::Serializer
    attributes :id, :name, :date_of_birth, :gender, :animal_name, :visits

  def visits
    object.visits.chronological.map do |visit|
      OwnerVisitSerializer.new(visit)
    end
  end
end
