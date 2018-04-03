class WishlistsController < ApplicationController
	  before_action :set_wishlist, only: [:show, :edit, :update, :destroy]


	def index
		@wishlist = []
		if Wishlist.exists?(user_id: current_user.id)
			a = Wishlist.find_by(user_id: current_user.id)
			a.product_id.each do |x|
				if Product.exists?(id: x)
					b = Product.find(x)
					@wishlist << b
				else
					x = nil
				end
			end
			a.product_id = a.product_id.compact
			a.save
		end
	end

	def addtowishlist
        if Wishlist.exists?(user_id: current_user.id)
	      a = Wishlist.find_by(user_id: current_user.id)
	      b = false
	      a.product_id.each do |x|
	        if x == params['product_id'].to_i
	          	b = true
	        end
          end
      	  if b == false
        	a.product_id << params['product_id'].to_i
      	  end
      	  a.save
	      # if params[:number].to_i == 1
	      #  	redirect_to request.referrer
	      # end
	      @a = params['product_id'].to_i
	      respond_to do |f|
		      f.html { redirect_to root_path }
		      f.js
		  end
    	else
	      a = Wishlist.new(user_id: current_user.id)
	      a.product_id << params['product_id'].to_i
	      a.save
	      @a = params['product_id'].to_i
	      respond_to do |f|
		      f.html { redirect_to root_path }
		      f.js
		  end
    	end
	end

	def deletewishlist
		a = Wishlist.find_by(user_id: current_user.id)
		a.product_id.delete(params[:product_id].to_i)
		a.save
		@a = params['product_id'].to_i
		if params[:number].to_i != 1
			respond_to do |f|
		      f.html { redirect_to root_path }
		      f.js
		  	end
		else
			redirect_to request.referrer
		end
	end

	def compare
		if Wishlist.exists?(user_id: current_user.id) 
			@a = Wishlist.find_by(user_id: current_user.id)
			if @a.compare.include?(params[:product_id].to_i)
			else
				@a.compare << params[:product_id].to_i
				@a.save
				@a
				@compare = Product.find(params['product_id'].to_i)
				
			       redirect_to request.referrer
			      
			  	
			end
		else
			@a = Wishlist.new(user_id: current_user.id)
			@a.compare << params['product_id'].to_i
	      	@a.save
	      	@compare = Product.find(params['product_id'].to_i)
			
		      redirect_to request.referrer 
		    
	    end
	end

	def delcompare
		@a = Wishlist.find_by(user_id: current_user.id)
		@a.compare.delete(params[:product_id].to_i)
		@a.save
		@b = params[:product_id].to_i
		respond_to do |f|
	      f.html { redirect_to request.referrer }
	      f.js
	  	end
	end

	def administration
		if current_user.admin

		else
			redirect_to root_path
		end
	end

	def adm_search
		@a = Order.find(params[:number])
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      @wishlist = Wishlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wishlist_params
      params.permit(:user_id, :product_id, :number)
    end
end
