class User < ApplicationRecord
    validates :username, uniqueness: true
    validates :username, :session_token, :password_digest, presence: true

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
            if user && user.is_password?(password)
                user 
            else
                return nil
            end
    end

    def password = (password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
	    bcryptObject = BCrypt::Password.new(self.password_digest)
        bcryptObject.is_password?(password)
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        return self.session_token
    end

    def ensure_session_token
	self.session_token ||= generate_session_token
	#database requires it and we don’t want it to break
    end

    def generate_unique_session_token
	    token = SecureRandom::urlsafe_base64
        while User.exists?(session_token: token)
	        token = SecureRandom::urlsafe_base64
        end
        token
    end

end
