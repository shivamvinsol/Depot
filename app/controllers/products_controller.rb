class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :show_image]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    respond_to do |format|
      format.json { render json: Product.select('title AS Name', 'categories.name AS Category').joins(:category) }
      format.html { render :index }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  def show_image
    send_data @product.image.data, type: @product.image.content_type, disposition: 'inline'
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    image = params[:product][:image]
    @product = Product.new(product_params)

    if image.present?
      @product.build_image(name: image[0].original_filename, data: image[0].read ,content_type: image[0].content_type)
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render 'new' } # if render new, @ categories doesn't get SET, NIL CLASS ERROR
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

    # to simply upload a file ---
    # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    #   file.write(uploaded_io.read)
    # end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    image = params[:product][:image]

    if image.present?
      @product.build_image(name: image[0].original_filename, data: image[0].read ,content_type: image[0].content_type)
    end

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
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to products_url, notice: 'Product has line items.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image, :price, :discount_price, :enabled, :permalink, :category_id)
    end
end
