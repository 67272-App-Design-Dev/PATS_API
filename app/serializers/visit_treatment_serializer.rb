class VisitTreatmentSerializer
  include FastJsonapi::ObjectSerializer
  set_type :treatment
  
  attribute :procedure do |object|
    object.procedure.name
  end

  attribute :successful

end