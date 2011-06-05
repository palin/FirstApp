class CommentsController < ApplicationController
  before_filter :require_user

  def create
    # params[:comment] => { :receiver_id => 2, :body => 'asdasd' }
    @comment = current_user.comments.build(params[:comment])

    if @comment.save
      redirect_to(user_path(@comment.receiver), :notice => "Utworzono komentarz")
    else
      @user = @comment.receiver
      @comments = @user.received_comments
      render :template => 'users/show'
    end
  end
  
  def delete
  	@comment_to_delete = current_user.comments.first(:conditions => ["id= ?", params[:id]]).destroy
  	redirect_to(user_path(current_user.id), :notice => "Usunieto komentarz")
  end

end
