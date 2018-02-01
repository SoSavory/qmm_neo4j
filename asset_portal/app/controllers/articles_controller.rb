class ArticlesController < ApplicationController
  def show
    @article = Article.where(uuid: params[:id]).with_associations(authors: :person).first
  end

  def index
    @articles = Article.all.with_associations(authors: :person)
  end
end
