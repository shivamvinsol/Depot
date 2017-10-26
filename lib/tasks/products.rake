namespace :products do
  desc "TODO"
  task set_category: :environment do
    products = Product.where(category_id: nil)
    category_id = Category.first.id
    products.each do |product|
      product.category_id = category_id
      product.save(validate: false)
    end
  end

end
