class AddSnippetToPost < ActiveRecord::Migration[6.1]
    def change
        add_column(:posts, :snippet, :text, null: false)
    end
end
