class RawArticlesController < ApplicationController

  # AJAX request client side hits this, then on complete callback triggers index with the given :raw_article_spline param.
  # Client side populates the pagination widget, and calculates the how the pages are split, as long as logic agrees. All this does is return a number
  def get_pagination_splines
    render json: RawArticle.where(importer: current_user).count()
  end

  def index
    @raw_articles = RawArticle.where(importer: current_user).limit(10).offset(10*params[:raw_article_spline].to_i)
    if params[:ajax] == "true"
      render partial: "raw_articles_index", layout: false
    end
  end

  def show
    raw_article = RawArticle.find(params[:id])
    if raw_article.importer == current_user
      @raw_article = raw_article
    else
      redirect_to login_path
    end
  end

  def curate
    article = Article.new()
  end

  private
  def raw_article_params
    params.require(:raw_article).permit()
  end
end
