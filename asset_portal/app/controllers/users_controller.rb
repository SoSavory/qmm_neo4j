class UsersController < ApplicationController

  def new
    @user = User.new()
  end

  def create
    @user = User.new(email: params[:user][:email],
                     password: params[:user][:password]
                    )
    @person = Person.new(first_name: params[:user][:first_name],
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
    @user = User.where(id: params[:id]).with_associations(person: :authors).first
    if @user.person
      @person = @user.person
      if @person.authors
        @authors = @person.authors
        if @authors.articles
          @articles = @authors.articles
        end
      end
    end
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

  private
  def user_params
    params.require(:user, :import).permit(:email, :password, :password_confirmation, :first_name, :last_name, :import)
  end
end
