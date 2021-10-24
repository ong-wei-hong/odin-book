class TextContent < ApplicationRecord
	has_one :post, as: :content

	validates :text, presence: true
end
