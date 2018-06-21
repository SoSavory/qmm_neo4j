class AuthorsController < ApplicationController
  def show
    @author = Author.where(id: params[:id]).with_associations(person: :user).first
    @articles = Article.where(authors: @author).with_associations(authors: :person)
  end

  def get_fields
    render partial: "form"
  end
end
