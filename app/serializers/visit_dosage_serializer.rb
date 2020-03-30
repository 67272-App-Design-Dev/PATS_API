class VisitDosageSerializer
  include FastJsonapi::ObjectSerializer
  set_type :dosage

  attribute :medicine do |object|
    object.medicine.name
  end

  attribute :units_given

end