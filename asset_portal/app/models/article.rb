class Article
  include Neo4j::ActiveNode
  include ActiveModel::Model

  has_many :in, :authors, type: :AUTHORED, model_class: :Author
  has_many :out, :tags, type: :TAGGED_BY, model_class: :Tag

  has_one :in, :raw_article, type: :ARTICLE, model_class: :RawArticle
  attr_accessor :curating_authors

  private

end
