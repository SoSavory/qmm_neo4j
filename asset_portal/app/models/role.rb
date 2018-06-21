class Role
  include Neo4j::ActiveNode
  property :name, type: String

  has_many :in, :users, type: :USER_ROLE, model_class: :User


end
