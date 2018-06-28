class Person
  include Neo4j::ActiveNode

  property :first_name, type: String
  property :last_name, type: String

  has_many :out, :authors, type: :AUTHORED_UNDER, model_class: :Author
  has_one :out, :user, type: :IS, model_class: :User


  def name
    unless self.first_name.blank?
      self.last_name.capitalize + ", " + self.first_name.capitalize
    else
      self.last_name.capitalize
    end
  end

  def first_name=(name)
    name.strip.downcase
  end

  def last_name=(name)
    name.strip.downcase
  end
end
