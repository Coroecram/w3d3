class ChangeVisitsDefault < ActiveRecord::Migration
  def change
    change_column :visits, :visits, :integer, default: 1
  end
end
