class UsersController < ApplicationController

  before_filter :require_user, :only => [:edit, :update, :destroy]
  before_filter :require_no_user, :only => [:new, :create]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @comments = @user.received_comments
    @comment = @user.comments.build(:receiver_id => @user.id)
    @inv_received = @user.received_invitations
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Successfully created user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end
end
