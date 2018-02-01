class Person
  include Neo4j::ActiveNode

  property :first_name, type: String
  property :last_name, type: String

  has_many :in, :author, type: :author, model_class: :Author
  has_one :in, :user, type: :user, model_class: :User

end
