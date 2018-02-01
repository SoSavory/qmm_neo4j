class Author
  include Neo4j::ActiveNode

  has_one :out, :person, type: :person, model_class: :Person
  has_many :in, :articles, type: :article, model_class: :Article

  property :institution, type: String

end
