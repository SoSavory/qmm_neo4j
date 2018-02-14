class Article
  include Neo4j::ActiveNode

  property :title, type: String
  property :abstract, type: String

  has_many :out, :authors, type: :author, model_class: :Author
  has_many :out, :curators, type: :curator, model_class: :User


end
