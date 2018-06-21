class CreateRole < Neo4j::Migrations::Base
  def up
    add_constraint :Role, :uuid
  end

  def down
    drop_constraint :Role, :uuid
  end
end
