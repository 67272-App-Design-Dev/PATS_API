class OwnerVisitSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :weight
  set_type :visit

  attribute :visit_fee do |object|
    ActionController::Base.helpers.number_to_currency(object.total_charge / 100)
  end
end