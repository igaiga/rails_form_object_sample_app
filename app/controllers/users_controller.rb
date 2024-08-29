class UsersController < ApplicationController
  before_action :set_user, only: %i[ show destroy ]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    # @user = User.new
    @user = UserRegistrationForm.new
    @user.user = User.new
  end

  # GET /users/1/edit
  def edit
    # @user = User.find(params[:id])
    @user = UserRegistrationForm.new
    @user.user = User.find(params[:id])
    @user.set_attributes
  end

  # POST /users
  def create
    # @user = User.new(user_params)
    @user = UserRegistrationForm.new(user_params)
    @user.user = User.new

    respond_to do |format|
      if @user.save
        # format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.html { redirect_to user_url(@user.user), notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    # @user = User.find(params[:id])
    @user = UserRegistrationForm.new(user_params)
    @user.user = User.find(params[:id])
binding.irb
    respond_to do |format|
      if @user.save
        # format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.html { redirect_to user_url(@user.user), notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      # params.require(:user).permit(:name, :email, :terms_of_service)
      params.require(:user_registration_form).permit(:name, :email, :terms_of_service)
    end
end
