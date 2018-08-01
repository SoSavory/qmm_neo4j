class Article
  include Neo4j::ActiveNode
  include ActiveModel::Model

  has_many :out, :tags, type: :TAGGED_BY, model_class: :Tag

  has_one :in, :raw_article, type: :ARTICLE, model_class: :RawArticle

  def self.search(search_text, tag_ids)
    if !tag_ids.blank? && !search_text.blank?
      self.as(:a).branch{
        raw_article.as(:r)
        .where("r.title CONTAINS({search_text}) OR r.abstract CONTAINS({search_text}) OR r.authors CONTAINS({search_text})")
      }
      .tags.query_as(:t)
      .where("(a)-[:TAGGED_BY]->(t)")
      .where("t.uuid IN {tag_ids}")
      .with('a, collect(t) as ts')
      .where('length(ts) = length({tag_ids})')
      .params(tag_ids: tag_ids, search_text: search_text)
    elsif tag_ids.blank? && !search_text.blank?
      self.as(:a).raw_article.as(:r)
      .where("r.title CONTAINS({search_text}) OR r.abstract CONTAINS({search_text}) OR r.authors CONTAINS({search_text})").params(search_text: search_text)
    elsif !tag_ids.blank? && tag_ids[0] != "ansr" && search_text.blank?
      self.as(:a).tags.query_as(:t)
      .where("(a)-[:TAGGED_BY]->(t)")
      .where("t.uuid IN {tag_ids}")
      .with('a, collect(t) as ts')
      .where('length(ts) = length({tag_ids})')
      .params(tag_ids: tag_ids)
    elsif tag_ids[0] == "ansr" && search_text.blank?
      self.as(:a).all
    end
  end

end
