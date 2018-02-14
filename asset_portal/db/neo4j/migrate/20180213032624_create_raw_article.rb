class CreateRawArticle < Neo4j::Migrations::Base
  def up
    add_constraint :RawArticle, :uuid
  end

  def down
    drop_constraint :RawArticle, :uuid
  end
end
