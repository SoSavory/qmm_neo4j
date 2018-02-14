class User
  include Neo4j::ActiveNode

  has_one :out, :person, type: :person, model_class: :Person

  has_many :in, :curated_articles, type: :curated_article, model_class: :Article
  has_many :in, :raw_articles, type: :raw_article, model_class: :RawArticle

  property :email, type: String
  property :token, type: String
  property :password_digest, type: String

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

  def first_name
    nil
  end

  def last_name
    nil
  end

  def import
    nil
  end

  private


end
