class Article
  include Neo4j::ActiveNode
  include ActiveModel::Model

  has_many :in, :authors, type: :AUTHORED, model_class: :Author
  has_many :out, :tags, type: :TAGGED_BY, model_class: :Tag

  has_one :in, :raw_article, type: :ARTICLE, model_class: :RawArticle
  attr_accessor :curating_authors

  def self.search(search_text, tag_ids)
    self.as(:a).branch{
      raw_article.as(:r)
      .where("r.title CONTAINS({search_text}) OR r.abstract CONTAINS({search_text}) OR r.authors CONTAINS({search_text})")
    }
    .tags.query_as(:t)
    .where("(a)-[:TAGGED_BY]->(t)")
    .where("t.uuid IN {tag_ids}")
    .with('a, collect(t) as ts')
    .where('length(ts) = length({tag_ids})')
    .where('')
    .params(tag_ids: tag_ids, search_text: search_text)
  end

end
