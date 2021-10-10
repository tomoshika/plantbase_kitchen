class Step < ApplicationRecord
  belongs_to :recipe
  attachment :process_image
end
