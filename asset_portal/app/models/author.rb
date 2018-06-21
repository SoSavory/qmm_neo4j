class Author
  include Neo4j::ActiveNode

  has_one :in, :person, type: :AUTHORED_UNDER, model_class: :Person
  has_many :out, :articles, type: :AUTHORED, model_class: :Article

  property :institution, type: String

end
