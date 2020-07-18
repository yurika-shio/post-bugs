class UsersController < ApplicationController
	def show
		@user = User.find(current_user.id)
		@articles = @user.articles
		@articles = Article.find_by(user_id: current_user.id)
	end

	def edit
		@user = User.find(current_user.id)
	end

  def update
  	@user = User.find(current_user.id)
  	if @user.update(user_params)
  		redirect_to user_path, notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end
  def index
    @users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end
end
