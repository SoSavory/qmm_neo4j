class RawArticle
  include Neo4j::ActiveNode

  has_one :out, :importer, type: :importer, model_class: :User

  property :arxiv_identifier, type: String
  property :short_arxiv_identifier, type: String
  property :datestamp, type: Date
  property :submitter, type: String
  property :title, type: String
  property :authors, type: String
  property :categories, type: String
  property :doi, type: String
  property :abstract, type: String



end
