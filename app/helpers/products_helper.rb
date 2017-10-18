module ProductsHelper
  def categories
    Category.pluck(:name, :id)
  end
end
