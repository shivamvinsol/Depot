# FIXME: image gets uploaded even if validation fails
# FIXME: use class instance variables, singleton class, got errors

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :show_image]
  before_action :delete_uploaded_images, only: :destroy

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

  # to display image saved as blob
  # def show_image
  #   send_data @product.images.first.data, type: @product.images.first.content_type, disposition: 'inline'
  # end

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
    @product = Product.new(product_params)
    validate_product_images

    respond_to do |format|
      if @product.save
        upload_product_images
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    validate_product_images
    respond_to do |format|
      if @product.update(product_params)
        upload_product_images
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
      params.require(:product).permit(:title, :description, :image1, :image2, :image3, :price, :discount_price, :enabled, :permalink, :category_id)
    end

    def validate_product_images
      @images = []
      3.times do |index|
        image = params[:product]["image#{index + 1}"]
        if image.present?
          @product.images.build(name: image.original_filename, content_type: image.content_type)
          @images << image
        end
      end
    end

    def upload_product_images
      product_image_path = "#{Rails.root}/public/images/#{@product.id}"
      Dir.mkdir(product_image_path) unless Dir.exist?(product_image_path)

      @images.each do |image|
        if %w(image/jpeg image/png image/gif).include?(image.content_type)
          File.open(product_image_path + "/#{image.original_filename}", 'wb') do |file|
            file.write(image.read)
          end
        end
      end
    end

    def delete_uploaded_images
      product_image_path = "#{Rails.root}/public/images/#{@product.id}"
      # SAFE TO USE??
      if Dir.exist?(product_image_path) && @product.present?
        FileUtils.rm_rf(product_image_path)
      end
    end
end

# this will save image as a blob
# @product.images.build(name: image.original_filename, data: image.read ,content_type: image.content_type)
