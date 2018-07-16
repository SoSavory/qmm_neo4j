class RawArticlesController < ApplicationController

  # AJAX request client side hits this, then on complete callback triggers index with the given :raw_article_spline param.
  # Client side populates the pagination widget, and calculates the how the pages are split, as long as logic agrees. All this does is return a number
  def get_pagination_splines
    render json: current_user.imports(:i).where("NOT((i)-[:ARTICLE]->())").pluck("count(*)").first
  end

  def index
    @raw_articles = current_user.imports(:i).where("NOT((i)-[:ARTICLE]->())").limit(10).offset(10*params[:raw_article_spline].to_i)
    if params[:ajax] == "true"
      render partial: "raw_articles_index", layout: false
    end
  end

  def show
    raw_article = RawArticle.find(params[:id])
    if raw_article.importer == current_user
      @raw_article = raw_article
      @tag_groups = TagGroup.all.with_associations(:tags)
      @article = Article.new()
    else
      redirect_to login_path
    end
  end

  def curate_raw_article
    if current_user.role_includes?(:librarian)
      @raw_article = RawArticle.find(params[:id])
      if @raw_article.importer == current_user
        @article = Article.new()
      end
    end
  end

  private
  def raw_article_params
    params.require(:raw_article).permit()
  end
end
