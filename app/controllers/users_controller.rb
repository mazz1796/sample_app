class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destory] #[:edit,:update] methodを実行する前に、signed_in_user methodを実行しろということ。
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user

  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    #@user = User.find(params[:id])  <-correct_user methodで実行しているので不要になった。
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end




  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in." 
      end
    end

    def correct_user
      @user = User.find(params[:id])

      redirect_to(root_path) unless current_user?(@user)
#here in controller, root_path is recognised, i can also use root_url, both are recognised

#but in spec folder, all the rspec tests that i wrote , they can only allow us to switch one option on, either use url or either use path

      #current_user methodはsessions_helperで定義される。
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
