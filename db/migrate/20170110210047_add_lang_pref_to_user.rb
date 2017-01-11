class AddLangPrefToUser < ActiveRecord::Migration
  def change
    change_table :users do |p|
      p.string :language,:default => "ESP", after: :salt
    end
  end
end
