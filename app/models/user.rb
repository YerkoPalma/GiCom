class User
  include Mongoid::Document
  include Mongoid::Paperclip
  include ActiveModel::SecurePassword
  field :name, type: String
  field :email, type: String
  field :avatar, type: String
  field :password_digest, type: String
  field :remember_token, type: String
  field :producto, type: String
  field :admin, type: Boolean
  field :_id, type: String, default: ->{ name } # Convierte el id del documento en su nombre, para mejor manejo de las URLs
  has_mongoid_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_secure_password

  #validations
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
