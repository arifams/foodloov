class Recipe < ApplicationRecord

	# This is for user and make relation with recipe
	belongs_to :user

	# This is the voting votable for user
	acts_as_votable

	# add inverse_of because I cannot save the ingredients. Stackoverflow said
	# When you include the inverse_of, rails now knows about those associations and will "match" them in memory.
	has_many :ingredients, inverse_of: :recipe
	has_many :directions, inverse_of: :recipe
	# This is the script to add ingredients and directions the form, got from cocoon gem and mackenzie child tips
	# to add form under the new recipe form and allow only if forms filled properly
	accepts_nested_attributes_for :ingredients, 
								   reject_if: proc { |attributes| attributes['name'].blank?}, 
								   allow_destroy: true
	accepts_nested_attributes_for :directions, 
								   reject_if: proc { |attributes| attributes['step'].blank?}, 
								   allow_destroy: true

	# This is the script to make user validation error if they don't have any title, image and description
	validates :title, :description, :image, presence: true

	# and this is to upload image and control the filename extension bt paperclip gem
	has_attached_file :image, styles: { 
		thumb: '100x100>',
		square: '200x200#',
		medium: "400x400#", 
	}
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	# This is to find out the last 12 characters youtube digit
	def youtube_code
		return if video.nil?
			
			# This is the code that mike taught me but it didn't recognize nil or youtube share link with / characters
			# url = URI.parse(video)
			# url.query.split('=').last
		
		url = URI.parse(video)
		url.query.try(:split, '=').try(:last) || self.video.try(:split, '/').try(:last) 
	end
end
