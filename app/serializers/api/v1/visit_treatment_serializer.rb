module Api::V1
  class VisitTreatmentSerializer < ActiveModel::Serializer
    attributes :id, :procedure_name, :successful
  end
end
