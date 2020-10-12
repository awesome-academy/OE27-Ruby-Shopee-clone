module Shops::ProductsConcern
  include ActiveSupport::Concern

  def load_products params
    Product.select_fields
      .with_deleted
      .by_created_at_and_deleted_at
      .includes(:brand, :category, :user)
      .search(params[:q])
  end
end
