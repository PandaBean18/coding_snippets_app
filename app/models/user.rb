class User < ApplicationRecord
    attr_reader :password

    validates :username, uniqueness: true, presence: true 
    validates :password_digest, presence: true 
    validates :session_token, presence: true 
    validates :password, length: { minimum: 6, allow_nil: true }
    before_validation :ensure_session_token 

    has_many(
        :posts, 
        class_name: 'Post', 
        foreign_key: 'user_id', 
        primary_key: 'id', 
        dependent: :destroy
    )

    has_many(
        :coding_snippets,
        class_name: 'Snippet', 
        foreign_key: 'user_id', 
        primary_key: 'id', 
        dependent: :destroy
    )

    after_initialize do |user| 
        user.session_token ||= User.generate_session_token
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end


    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        return nil if user.nil? 

        user.is_password?(password) ? user : nil
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end 

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save!
        return self.session_token
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    private 

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end 
end
