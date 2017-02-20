class User < ActiveRecord::Base
  after_initialize :ensure_session_token

  validates(
    :username,
    :password_digest,
    :session_token,
    presence: true
  )
  validates(
    :username,
    :session_token,
    uniqueness: true
  )

  attr_reader :password

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user && user.valid_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
