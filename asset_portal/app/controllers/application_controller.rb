class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :setup_search

  private

  def setup_search
    @tag_groups ||= TagGroup.all.with_associations(:tags)
  end
end
