class Tag
  include Neo4j::ActiveNode
  property :name, type: String
  has_one :out, :tag_group, type: :GROUPED_BY, model_class: :TagGroup
  has_many :in, :articles, type: :TAGGED_BY, model_class: :Article


end
