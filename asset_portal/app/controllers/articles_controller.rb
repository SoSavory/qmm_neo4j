class ArticlesController < ApplicationController
  def show
    @article = Article.where(uuid: params[:id]).with_associations(authors: :person).first
  end

  def index
    @articles = Article.all.with_associations(authors: :person)
  end

  def create
    authors = []
    puts params[:article][:curating_authors]
    params[:article][:curating_authors].each { |k,v|
      person = Person.find_or_create(first_name: v[:person][:first_name].strip.downcase, last_name: v[:person][:last_name].strip.downcase)
      author_init = person.authors.where(institution: v[:institution])
      author = author_init.exists? ? author_init : Author.create(institution: v[:institution])
      person.authors << author
      authors << author
    }

    tags = Tag.find(params[:article][:tag_ids].uniq.reject{|t| t.blank? })
    raw_article = RawArticle.find(params[:article][:raw_article_id])
    a = Article.new()
    a.authors << authors
    a.raw_article = raw_article
    a.tags << tags
    a.save
    redirect_to raw_articles_path
  end

  private
  def article_params
    params.require(:article).permit(:tag_ids, curating_authors: [])
  end
end
# (:tag_ids, :raw_article_id, curating_authors_attributes: {person: [:first_name, :last_name]})
