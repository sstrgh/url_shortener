class CreateShortUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :short_urls do |t|
      t.text :base_url
      t.string :shortened_url
      t.timestamps
    end
  end
end
