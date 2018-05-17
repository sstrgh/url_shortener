class AddTotalVisitsToShortUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :short_urls, :total_visits, :integer, :default => 0
  end
end
