module Shops::ProductsConcern
  include ActiveSupport::Concern

  def load_products params, current_user
    current_user.products
      .select_fields
      .with_deleted
      .by_created_at_and_deleted_at
      .includes(:brand, :category)
      .search(params[:q])
  end
end
