class RatingsController < ApplicationController
  def update_or_create
    attributes = rating_params
    user_product_rating = Rating.find_or_create_by({user_id: session[:user_id], product_id: attributes[:product_id] })
    user_product_rating.rating = attributes[:rating]

    if user_product_rating.save
      new_rating = Rating.where(product_id: attributes[:product_id]).average(:rating).round(2)
      render json: { new_rating: new_rating }, status: 200
    else
      render json: {}, status: 500
    end
  end

  private
    def rating_params
      params.permit(:product_id, :rating)
    end
end
