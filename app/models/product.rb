class Product < ApplicationRecord
	mount_uploaders :images, ImageUploader
	has_many :comments



	def self.search(term)
  		if term
    		where('title LIKE ?', "%#{term}%")
  		else
    		all
  		end
	end
end
