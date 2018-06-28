class AuthorsController < ApplicationController
  def show
    @author = Author.find_by(id: params[:id])
  end

  def get_fields
    render partial: "form"
  end
end
