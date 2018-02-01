class User
  include Neo4j::ActiveNode

  has_one :out, :person, type: :person, model_class: :Person

  property :email, type: String
end
