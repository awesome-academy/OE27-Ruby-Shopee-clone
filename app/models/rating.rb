class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user

  after_save :update_star

  private
  def update_star
    count_rate = product.count_rate + 1
    total_star = product.total_star + star
    avgstar = total_star / count_rate.to_f
    product.update_columns count_rate: count_rate, avg_star: avgstar, total_star: total_star
  end
end
