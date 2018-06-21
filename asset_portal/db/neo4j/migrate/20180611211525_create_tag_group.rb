class CreateTagGroup < Neo4j::Migrations::Base
  def up
    add_constraint :TagGroup, :uuid
  end

  def down
    drop_constraint :TagGroup, :uuid
  end
end
