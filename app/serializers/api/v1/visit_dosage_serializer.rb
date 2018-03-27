module Api::V1
  class VisitDosageSerializer < ActiveModel::Serializer
    attributes :id, :medicine_name, :units_given
  end
end
