class AddImageToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :image, :string, :default => "https://sagemailer.com/blog/content/images/2019/12/Amazon-review-request-button.jpg"
  end
end
