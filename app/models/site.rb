class Site < ApplicationRecord
  belongs_to :organisation

  scope :public_sites, -> { where(public: true) }
end
