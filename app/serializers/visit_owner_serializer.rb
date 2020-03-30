class VisitOwnerSerializer
  include FastJsonapi::ObjectSerializer
  set_type :owner
  attributes :proper_name

end