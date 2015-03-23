class Question < ActiveRecord::Base
  has_many :answer, dependent: :destroy
  validates :description, presence: true
end
