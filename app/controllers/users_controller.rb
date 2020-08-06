class UsersController < ApplicationController
	def show
		@user = User.find(current_user.id)
		@articles = @user.articles
		@articles = Article.where(user_id: current_user.id).page(params[:page]).reverse_order
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
    @users = User.all
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end
end
