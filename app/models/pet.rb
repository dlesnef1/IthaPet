class Pet < ActiveRecord::Base
  belongs_to :user
  validates :image, presence: true
  validates :name, presence: true
  validates :biography, presence: true, length: { maximum: 500 }
end
