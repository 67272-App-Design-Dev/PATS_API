module Api::V1
  class PetVisitSerializer < ActiveModel::Serializer
      attributes :id, :date, :weight, :visit_fee, :dosages, :treatments

    def visit_fee
      ActionController::Base.helpers.number_to_currency(object.total_charge / 100)
    end

    def dosages
      object.dosages.map do |dosage|
        VisitDosageSerializer.new(dosage)
      end
    end

    def treatments
      object.treatments.map do |treatment|
        VisitTreatmentSerializer.new(treatment)
      end
    end
  end
end
