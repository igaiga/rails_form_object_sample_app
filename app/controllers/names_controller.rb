class NamesController < ApplicationController
  # GET /names/new
  def new
    @user_name_form = UserNameForm.new(model: User.new)
  end

  # GET /names/1/edit
  def edit
    @user_name_form = UserNameForm.new(model: User.find(params[:id]))
  end

  # POST /names
  def create
    @user_name_form = UserNameForm.new(model: User.new, **name_params)

    if @user_name_form.save
      redirect_to user_url(@user_name_form.user), notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /names/1
  def update
    @user_name_form = UserNameForm.new(model: User.find(params[:id]), **name_params)

    if @user_name_form.save
      redirect_to user_url(@user_name_form.user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def name_params
    params.require(:user_name_form).permit(:name)
  end
end
