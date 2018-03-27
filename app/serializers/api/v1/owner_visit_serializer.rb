module Api::V1
  class OwnerVisitSerializer < ActiveModel::Serializer
      attributes :id, :date, :weight, :visit_fee

    def visit_fee
      ActionController::Base.helpers.number_to_currency(object.total_charge / 100)
    end
  end
end
