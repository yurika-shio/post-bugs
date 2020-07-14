class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action  :set_article_tags_to_gon, only: [:edit]

  # GET /articles
  # GET /articles.json
  def index
    #@articles = Article.all
    if params[:category_id]
      @selected_category = Category.find(params[:category_id])
      @articles= Article.from_category(params[:category_id]).page(params[:page])
    else
      @articles= Article.where(is_completed: true).page(params[:page])
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    #@user = @articles.user
    @article= Article.find(params[:id])
    if params[:category_id]
      @selected_category = Category.find(params[:category_id])
      @articles= Article.from_category(params[:category_id]).page(params[:page])
    else
      @article= Article.find(params[:id])
    end
    @comment = Comment.new
    @comments = @article.comments
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article= Article.find(params[:id])
    @category_list = @article.categories.pluck(:name).join(",")
  end

  # POST /articles
  # POST /articles.json
  def create
    @article= current_user.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
        render 'articles/new'
      end

      if @article.save
        if params[:button1]
           @article.update(is_completed: true)
         end
      end
    end

    category_list = params[:category_list].split(",")
    if @article.save
      @article.save_categories(category_list)
      flash[:success] = "記事を作成しました"
    else
      render 'articles/new'
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article= Article.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    category_list = params[:category_list].split(",")
    if @article.update_attributes(article_params)
      @article.save_categories(category_list)
      flash[:success] = "記事を更新しました"
    else
      render 'edit'
    end

    if @article.update(article_params)
        if params[:button1]
           @article.update(is_completed: true)
         elsif params[:button2]
          @article.update(is_completed: false)
         end
      end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_article_tags_to_gon
      gon.article_tags = @article.categories.pluck(&:category_name)
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :error_name, :introduction, :factor, :result, :reference)
    end
end
