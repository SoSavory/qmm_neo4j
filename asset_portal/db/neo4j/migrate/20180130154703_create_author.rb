class CreateAuthor < Neo4j::Migrations::Base
  def up
    add_constraint :Author, :uuid
  end

  def down
    drop_constraint :Author, :uuid
  end
end
