class CreateSnippets < ActiveRecord::Migration[6.1]
    def change
        create_table :snippets do |t|
            t.integer :post_id, null: false
            t.integer :user_id, null: false 
            t.text :code, null: false 
            t.string :language, null: false 
            t.timestamps
        end
    end
end
