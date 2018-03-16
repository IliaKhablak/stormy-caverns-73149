class BucketsController < ApplicationController
  before_action :set_bucket, only: [:show, :edit, :update, :destroy]

  # GET /buckets
  # GET /buckets.json
  def index
    if Bucket.find_by(user_id: current_user.id).present?
      @buckets = []
      @a = Bucket.find_by(user_id: current_user.id)
      @a.product_id.each do |b|
        c = Product.find(b[0])
        @buckets << c
      end
      @buckets
      @a
    end
  end

  def addtobucket
    if Bucket.find_by(user_id: current_user.id).present?
      a = Bucket.find_by(user_id: current_user.id)
      b = false
      a.product_id.each do |x|
        if x[0] == params['product_id'].to_i
          x[1] = x[1] + 1
          b = true
        end
      end
      if b == false
        a.product_id << [params['product_id'],1]
      end
      a.save
      if params[:number].to_i == 1
        redirect_to request.referrer
      end
    else
      a = Bucket.new(user_id: current_user.id, product_id: [[params['product_id'],1]])
      a.save
      if params[:number].to_i == 1
        redirect_to request.referrer
      end
    end

  end

  def deletebucket
    a = Bucket.find_by(user_id: current_user.id)
    b = 0
    c = nil
    a.product_id.each do |x|
      if x[0] == params[:product_id].to_i
        x[1] = x[1] - params[:number].to_i
      end
      if x[1] <= 0
        c = b
      end
      b = b + 1
    end
    if c != nil
      a.product_id.delete_at(c)
    end
    a.save
    redirect_to request.referrer
  end
  # GET /buckets/1
  # GET /buckets/1.json
  def show
  end

  # GET /buckets/new
  def new
    @bucket = Bucket.new
  end

  # GET /buckets/1/edit
  def edit
  end

  # POST /buckets
  # POST /buckets.json
  def create
    @bucket = Bucket.new(bucket_params)

    respond_to do |format|
      if @bucket.save
        format.html { redirect_to @bucket, notice: 'Bucket was successfully created.' }
        format.json { render :show, status: :created, location: @bucket }
      else
        format.html { render :new }
        format.json { render json: @bucket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buckets/1
  # PATCH/PUT /buckets/1.json
  def update
    respond_to do |format|
      if @bucket.update(bucket_params)
        format.html { redirect_to @bucket, notice: 'Bucket was successfully updated.' }
        format.json { render :show, status: :ok, location: @bucket }
      else
        format.html { render :edit }
        format.json { render json: @bucket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buckets/1
  # DELETE /buckets/1.json
  def destroy
    @bucket.destroy
    respond_to do |format|
      format.html { redirect_to buckets_url, notice: 'Bucket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bucket
      @bucket = Bucket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bucket_params
      params.permit(:user_id, :product_id, :number)
    end
end
