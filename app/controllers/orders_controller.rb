class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  require "rubygems"
  require "braintree"

  
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(user_id: current_user.id)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    
    @product = []
    @order.product_id.each do |z|
      a = Product.find(z[0])
      @product << a
    end
    @product
    @order
  end

  # GET /orders/new
  def new
    @order = Order.new
    @a = []
    x = 0
    @b = Bucket.find_by(user_id: current_user.id)
    @b.product_id.each do |c|
      v = Product.find(c[0])
      x = x + v.price*c[1]
      @a << [v, v.price*c[1], c[1]]
    end
    @a << x
    @a
    @b
    @order
  end

  def checkout
    nonce_from_the_client = params[:payment_method_nonce]
    result = gateway.transaction.sale(
      :amount => "10.00",
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )
  end

  # GET /orders/1/edit
  def edit
  end

  def payment
    if Order.exists?(id: params[:id])
      @order = Order.find(params[:id])
      if @order.user_id == current_user.id && @order.complit == false
        gateway = Braintree::Gateway.new(
          :environment => :sandbox,
          :merchant_id => ENV["bt_merchant_id"],
          :public_key => ENV["bt_public_key"],
          :private_key => ENV["bt_private_key"]
        )
        @token = gateway.client_token.generate
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order[:user_id] = current_user.id
    @order.price = params['price']
    a = params["product_id"].split(' ')
    b = a.each_slice(2).to_a
    @order.product_id = b
    @order.save
    respond_to do |format|
      if @order.save
        format.html { redirect_to '/payment/'+@order.id.to_s}
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def create2
    if Order.exists?(id: params[:id])
      @order = Order.find(params[:id])
      @order.product_id.each do |x|
        v = Product.find(x[0].to_i)
        v.stock = v.stock - x[1].to_i
        v.save
      end
      @order.complit = true
      @order.save
      c = Bucket.find_by(user_id: current_user.id)
      c.destroy
      @user = User.find(current_user.id)
      ApplicationMailer.sample_email(@user, @order).deliver_now
      respond_to do |format|
          format.html { redirect_to root_path, notice: 'Order was successfully finished.' }
          format.json { render :show, status: :ok, location: @order }
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :complit, :payment_method_nonce, :price, :adress, :product_id => [] )
    end
end
