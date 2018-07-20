class ArticlesController < ApplicationController
  def show
    @article = Article.find_by(uuid: params[:id])
  end

  def index
    # Need to refactor this to take pagination
    spline = params[:search_result_article_spline] || 0
    @articles_count = Article.all.pluck("count(*)").first
    @searched_params = { search_text: '', search_tags: ["ansr"] }
    @articles =  Article.search('', ["ansr"]).limit(10).offset(10*params[:search_result_article_spline].to_i).pluck(:a)

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
    # Have to save search params somehow

    @articles =  Article.search(params[:search][:search_text], params[:search][:tag_ids].uniq.reject{|t| t.blank? }).limit(10).offset(10*params[:search_result_article_spline].to_i).pluck(:a)
    @articles_count = Article.search(params[:search][:search_text], params[:search][:tag_ids].uniq.reject{|t| t.blank? }).pluck("count(*)").first

    @searched_params = {search_text: params[:search][:search_text], search_tags: params[:search][:tag_ids]}

    if params[:ajax] == "true"
      render partial: "search_results", layout: false
    else
      render "index"
    end
  end

  private
  def article_params
    params.require(:article).permit(:tag_ids, :search_text)
  end
end
