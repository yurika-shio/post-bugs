class SearchesController < ApplicationController
	before_action :authenticate_user!

  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @records = search_for(@model,@content).page(params[:page]).per(5)
  end

  private
  def search_for(model,content)
    if model == 'user'
      User.where('name LIKE ?', '%'+content+'%')

    else
      Article.where('title LIKE ?', '%'+content+'%')

    end
  end
end
