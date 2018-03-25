class VisitSerializer < ActiveModel::Serializer
  # attributes :id, :date, :weight, :total_charge
  attributes :id, :date, :weight, :visit_fee

  # Relationships
  # belongs_to :pet
  # has_one :animal, through: :pet
  # has_many :dosages
  # has_many :treatments
  # has_one :owner, through: :pet

  def visit_fee
    ActionController::Base.helpers.number_to_currency(object.total_charge / 100)
  end
end
