class CommentsController < ApplicationController
	def create
		@article = Article.find(params[:article_id])
		@areticle_new = Article.new
		@comment = @article.comments.new(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			flash[:success] = "Comment was successfully created."
			redirect_to article_path(@article)
		else
			@comments = Comment.where(article_id: @article.id)
			render '/articles/show'
		end
	end

	def destroy
		@comment = Comment.find(params[:article_id])
		if @comment.user != current_user
			redirect_to request.referer
		end
		@comment.destroy
		redirect_to request.referer
	end

	private

	def comment_params
		params.require(:comment).permit(:comment)
	end
end
