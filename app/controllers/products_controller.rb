class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  # GET /products
  # GET /products.json
  def index
    @wish = Wishlist.where("user_id = ?", current_user.id).first
    @categoryes = Categorye.all
    if params[:category].present?
      @products = Product.where(category: params[:category])
    else
      @products = Product.search(params[:term])
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if !current_user.admin
      @product.statistic = @product.statistic + 1
      @product.save
    end
    @wish = Wishlist.where("user_id = ?", current_user.id).first
    @comments = Comment.where(product_id: @product.id).order(:created_at)
    @comment = @product.comments.build
    
  end

  # GET /products/new
  def new
    if current_user.admin?
      @product = Product.new
    else
      redirect_to root_path
    end
  end

  def rate
    @a = Product.find(params[:product_id].to_i)
    @a.rate_user << current_user.id
    @a.rating << params[:rating].to_i
    @a.save
    respond_to do |f|
      f.html { render @a }
      f.js
    end
  end

  # GET /products/1/edit
  def edit    
    if current_user.admin?
    else
      redirect_to root_path
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    if Categorye.find_by(title: params[:category]).present?
    else
      a = Categorye.new(title: params[:category])
      a.save
    end
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @b = @product.id
    @product.destroy
  end

  private


    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :stock, :price, :rating, :product_id, :category, :like => [], :images => [])
    end
end
