class ImageContent < ApplicationRecord
	has_one :post, as: :content

  has_one_attached :image
end
