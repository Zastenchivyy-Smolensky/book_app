class UsersController < ApplicationController
  before_action :authenticate_user,{only:[:index, :show, :edit, :update]}
  before_action :forbid_login_user,{only: [:new, :create, :login_form,:login]}
  before_action :ensure_correct_user,{only: [:edit,:update]}
  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email],
      image_name: "araiguma1.jpg",
      password: params[:password]
    )
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if @user
      flash[:notice] = "ユーザーを変更しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end
  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @errors_messages="emailまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("/users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/users/index")
  end
  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end
  def ensure_correct_user
    if params[:id].to_i != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
