class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_work_categories

	def set_work_categories
		@compare = []
		if  user_signed_in?
			if Wishlist.exists?(user_id: current_user.id) 
				a = Wishlist.find_by(user_id: current_user.id)
				a.compare.each do |x|
					b = Product.find(x)
					@compare << b 
				end
			end
		end
	end
end
