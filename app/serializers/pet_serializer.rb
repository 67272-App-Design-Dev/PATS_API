class PetSerializer < ActiveModel::Serializer
  # attributes :id, :name, :date_of_birth, :gender, :animal_name
  attributes :id, :name, :date_of_birth, :gender, :animal_name, :visits

  # Relationships
  # belongs_to :animal
  # belongs_to :owner
  # has_many :visits
  # has_many :dosages, through: :visits
  # has_many :treatments, through: :visits

    def visits
    object.visits.chronological.map do |visit|
      VisitSerializer.new(visit)
    end
  end
end
