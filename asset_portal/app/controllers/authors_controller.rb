class AuthorsController < ApplicationController
  def show
    @author = Author.where(id: params[:id]).with_associations(person: :user).first
    @articles = Article.where(authors: @author).with_associations(authors: :person)
  end
end
