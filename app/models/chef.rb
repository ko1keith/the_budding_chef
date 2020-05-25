class Chef < ApplicationRecord

  validates :chefname, presence: true
  validates :email, presence: true

end
