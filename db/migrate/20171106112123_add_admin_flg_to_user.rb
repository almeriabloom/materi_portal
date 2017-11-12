class AddAdminFlgToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin_flg, :boolean
  end
end
