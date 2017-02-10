class User < ActiveRecord::Base
  include BCrypt
  has_many :sent_messages, class_name: :Message, foreign_key: :sender_id
  has_many :received_messages, class_name: :Message, foreign_key: :receiver_id

  # validates :username, :email, { presence: true }
  # validates :username, :email, { uniqueness: true }
  # validates :email, format: { with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/ }
  # validate :check_password

  def check_password
    if @raw_password && @raw_password.length < 4
      @errors.add(:password, "needs to be 4 characters or more")
    end
  end

  def authenticate?(password)
      self.password == password
  end

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(new_password)
    @raw_password = new_password
    @password = Password.create(@raw_password)
    self.hashed_password = @password
  end

end
