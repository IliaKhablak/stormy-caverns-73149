class Product < ApplicationRecord
	# has_many :comments
	# has_many :pictures, dependent: :destroy



	def self.search(term)
  		if term
    		where('title LIKE ?', "%#{term}%")
  		else
    		all
  		end
	end
end
