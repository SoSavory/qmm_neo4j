class User
  include Neo4j::ActiveNode

  has_one :out, :person, type: :IS, model_class: :Person

  has_many :out, :imports, type: :IMPORTED_BY, model_class: :RawArticle
  has_many :out, :roles, type: :USER_ROLE, model_class: :Role

  property :email, type: String
  property :token, type: String
  property :password_digest, type: String

  attr_accessor :first_name, :last_name

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest).is_password?(unencrypted_password) && self
  end

  def self.digest(string)
    BCrypt::Password.create(string, cost: 10)
  end

  def password=(unencrypted_password)
    if unencrypted_password.nil?
      self.password_digest = nil
    elsif !unencrypted_password.empty?
      @password = unencrypted_password
      cost = BCrypt::Engine::cost
      self.password_digest = BCrypt::Password.create(unencrypted_password, cost: cost)
    end
  end

  def password_confirmation=(unencrypted_password)
    @password_confirmation = unencrypted_password
  end

  def role_includes?(role)
    self.roles.pluck(:name).map{|r| r.to_sym }.include?(role)
  end

  private


end
