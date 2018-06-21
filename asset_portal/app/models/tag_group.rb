class TagGroup
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :in, :tags, type: :GROUPED_BY, model_class: :Tag


end
