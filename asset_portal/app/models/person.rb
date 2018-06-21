class Person
  include Neo4j::ActiveNode

  property :first_name, type: String
  property :last_name, type: String

  has_many :out, :authors, type: :AUTHORED_UNDER, model_class: :Author
  has_one :out, :user, type: :IS, model_class: :User

end
