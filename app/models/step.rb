class Step < ApplicationRecord
  # validates :process, presence: true

  belongs_to :recipe
  attachment :process_image
end
