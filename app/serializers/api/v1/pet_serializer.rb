module Api::V1
  class PetSerializer < ActiveModel::Serializer
    attributes :id, :name, :date_of_birth, :gender, :animal_name, :owner, :visits

    def owner
      PetOwnerSerializer.new(object.owner)
    end

    def visits
      object.visits.chronological.map do |visit|
        PetVisitSerializer.new(visit)
      end
    end
  end
end