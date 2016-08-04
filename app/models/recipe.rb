class Recipe < ApplicationRecord

	has_many :ingredients
	has_many :directions
	# This is the script to add ingredients and directions the form, got from cocoon gem and mackenzie child tips
	accepts_nested_attributes_for :ingredients, 
								   reject_if: proc { |attributes| attributes['name'].blank?}, 
								   allow_destroy: true
	accepts_nested_attributes_for :directions, 
								   reject_if: proc { |attributes| attributes['name'].blank?}, 
								   allow_destroy: true

	# This is the script to make user validation error if they don't have any title, image and description
	validates :title, :description, :image, presence: true

	has_attached_file :image, styles: { medium: "300x300#", }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
