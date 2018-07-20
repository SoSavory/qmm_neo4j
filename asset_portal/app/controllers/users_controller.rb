class UsersController < ApplicationController

  def new
    @user = User.new()
    @person = Person.new
  end

  def create
    @user = User.new(email: params[:user][:email],
                     password: params[:user][:password]
                    )
    @person = Person.find_or_create(first_name: params[:user][:first_name],
                         last_name: params[:user][:last_name]
                        )

    @user.person = @person
    @person.user = @user
    @user.save!
    @person.save!
    log_in(@user)
    redirect_to @user
  end

  def show
    @user = User.where(id: params[:id]).with_associations(:imports, :person).first
    @curations = @user.imports.article.pluck("count(*)").first
  end

  def index
    @users = User.all.with_associations(:person)
    @users_count = User.all.pluck("count(*)").first
  end

  def import_specific
    @raw_article = RawArticle.new
    @article = Article.new
  end

  def parse_import_specific
    unless RawArticle.where(short_arxiv_identifier: params[:raw_article][:short_arxiv_identifier]).exists?
      raw_article = RawArticle.new(arxiv_identifier: params[:raw_article][:arxiv_identifier],
                                   short_arxiv_identifier: params[:raw_article][:short_arxiv_identifier],
                                   datestamp: params[:raw_article][:datestamp],
                                   submitter: params[:raw_article][:submitter],
                                   title: params[:raw_article][:title],
                                   authors: params[:raw_article][:authors],
                                   categories: params[:raw_article][:categories],
                                   doi: params[:raw_article][:doi],
                                   abstract: params[:raw_article][:abstract])
      raw_article.importer = current_user
      raw_article.save!

      tags = Tag.where(uuid: params[:raw_article][:tag_ids].uniq.reject{|t| t.blank? })

      article = Article.new()
      article.tags << tags
      article.raw_article = raw_article
      article.save
    end
    redirect_to import_specific_path
  end

  def import
    @import = "import"
  end

  def parse_import
    import = Nokogiri::XML(File.read(params[:import][:import].tempfile)) do |config|
      config.nonet
    end

    records = import.css('record')
    records.each do |record|
      short_identifier = record.css('metadata arXivRaw id').text
      unless RawArticle.where(short_arxiv_identifier: short_identifier).exists?

        arxiv_identifier = record.css('header identifier').text
        datestamp  = record.css('header datestamp').text.to_date
        submitter  = record.css('metadata arXivRaw submitter').text
        title      = record.css('metadata arXivRaw title').text
        authors    = record.css('metadata arXivRaw authors').text
        categories = record.css('metadata arXivRaw categories').text
        doi        = record.css('metadata arXivRaw doi').text
        abstract   = record.css('metadata arXivRaw abstract').text

        raw_article = RawArticle.new(arxiv_identifier: arxiv_identifier,
                                     short_arxiv_identifier: short_identifier,
                                     datestamp: datestamp,
                                     submitter: submitter,
                                     title: title,
                                     authors: authors,
                                     categories: categories,
                                     doi: doi,
                                     abstract: abstract)
        raw_article.importer = current_user
        raw_article.save!
      end
    end

    redirect_to import_path
  end


  # We dont need a pagination_spline method because we preload the count in the show method.
  def get_user_curated_articles

    @curated_articles = User.find(params[:id]).imports.article.limit(10).offset(10*params[:curated_article_spline].to_i)
    if params[:ajax] == "true"
      render partial: "curated_articles_list", layout: false
    end
  end

  private
  def user_params
    params.require(:user, :import, :raw_article).permit(:email, :password, :password_confirmation, :first_name, :last_name, :import)
  end
end
