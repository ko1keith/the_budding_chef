class Like < ApplicationRecord
    belongs_to :chef
    belongs_to :recipe

    #enforce chef_id to only be associated with a like and a recipe once
    validates_uniqueness_of :chef, scope: :recipe

end