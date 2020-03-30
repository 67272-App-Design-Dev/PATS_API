class VisitSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :weight

  attribute :pet do |object|
    VisitPetSerializer.new(object.pet).serializable_hash
  end

  # attribute :owner do |object|
  #   VisitOwnerSerializer.new(object.owner).serializable_hash
  # end

  attribute :visit_fee do |object|
    ActionController::Base.helpers.number_to_currency(object.total_charge / 100)
  end

  attribute :dosages do |object|
    object.dosages.map do |dosage|
      VisitDosageSerializer.new(dosage).serializable_hash
    end
  end

  attribute :treatments do |object|
    object.treatments.map do |treatment|
      VisitTreatmentSerializer.new(treatment).serializable_hash
    end
  end

end
