class AddDefaultToStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:cat_rental_requests, :status, 'PENDING')
  end
end
