class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :user_id
      t.integer :attachable_id
      t.string :attachable_type
      t.string :content_name
      t.string :filename
      t.string :url
      t.text :content_meta
      t.string :description

      t.timestamps
    end
  end
end
