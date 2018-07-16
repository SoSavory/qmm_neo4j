class ArticlesController < ApplicationController
  def show
    @article = Article.where(uuid: params[:id]).with_associations(:tags).first
  end

  def index
    # Need to refactor this to take pagination
    @articles = Article.all
  end

  def create
    # This needs to be refactored to not rely on raw_article_id, and should check user validity
    tags = Tag.where(uuid: params[:article][:tag_ids].uniq.reject{|t| t.blank? })
    raw_article = RawArticle.find(params[:article][:raw_article_id])
    a = Article.new()
    a.raw_article = raw_article
    a.tags << tags
    a.save
    redirect_to raw_articles_path
  end

  def search
    @articles =  Article.search(params[:search][:search_text], params[:search][:tag_ids].uniq.reject{|t| t.blank? }).pluck(:a)
    render "index"
  end

  private
  def article_params
    params.require(:article).permit(:tag_ids, :search_text)
  end
end
