class AddHeadingToPosts < ActiveRecord::Migration[6.1]
    def change
        add_column(:posts, :heading, :string, null: false)
    end
end
