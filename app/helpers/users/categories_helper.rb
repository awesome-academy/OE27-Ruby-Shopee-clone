module Users::CategoriesHelper
  def load_categories_origin
    @categories = Category.top_level
  end
end
