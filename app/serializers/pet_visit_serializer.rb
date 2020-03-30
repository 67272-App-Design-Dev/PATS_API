class PetVisitSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :weight
  set_type :visit
end