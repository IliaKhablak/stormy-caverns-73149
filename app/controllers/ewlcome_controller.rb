class EwlcomeController < ApplicationController
skip_before_action :authenticate_user!, only: [:show, :index]
	def index
		if user_signed_in?
			redirect_to products_url
		else
		end
	end
end
