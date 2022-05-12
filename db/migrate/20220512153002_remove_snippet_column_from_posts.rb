class RemoveSnippetColumnFromPosts < ActiveRecord::Migration[6.1]
    def change
        remove_column(:posts, :snippet)
    end
end
