class Post < ApplicationRecord
    validates :user_id, :description, presence: true

    has_many(
        :coding_snippets, 
        class_name: 'Snippet', 
        foreign_key: 'post_id', 
        primary_key: 'id', 
        dependent: :destroy
    )

    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: 'user_id',
        primary_key: 'id'
    )

end
