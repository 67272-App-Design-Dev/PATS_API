class VisitSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :weight

  attribute :pet_name do |object|
    object.pet.name 
  end

  attribute :owner_name do |object|
    object.owner.name
  end

  attribute :visit_fee do |object|
    ActionController::Base.helpers.number_to_currency(object.total_charge / 100)
  end
end
