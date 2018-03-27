module Api::V1
  class VisitOwnerSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
