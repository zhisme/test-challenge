class AllowedList < ApplicationRecord
  validates :code, presence: true
end
