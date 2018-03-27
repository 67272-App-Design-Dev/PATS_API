module Api::V1
  class VisitPetSerializer < ActiveModel::Serializer
    attributes :id, :name, :animal_name, :date_of_birth
  end
end
