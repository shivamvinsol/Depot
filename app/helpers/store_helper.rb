module StoreHelper
  def rating_scale(product)
    scale = []
    (0.5..5).step(0.5).each do |rating|
      scale << rating
    end

    @user_product_rating = product.ratings.find_by(user_id: session[:user_id])
    if @user_product_rating.present?
      return scale, @user_product_rating.rating.to_f
    else
      return scale, ""
    end
  end

  def average_product_rating(product)
    if product.ratings.present?
      "#{product.ratings.average(:rating).to_f.round(2)}"
    else
      "Data Not Available"
    end
  end
end
