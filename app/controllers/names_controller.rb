class NamesController < ApplicationController
  # GET /names/new
  def new
    @name = UserNameForm.new(model: User.new)
  end

  # GET /names/1/edit
  def edit
    @name = UserNameForm.new(model: User.find(params[:id]))
  end

  # POST /names
  def create
    @name = UserNameForm.new(model: User.new, **name_params)

    if @name.save
      redirect_to user_url(@name.user), notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /names/1
  def update
    @name = UserNameForm.new(model: User.find(params[:id]), **name_params)

    if @name.save
      redirect_to user_url(@name.user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def name_params
    params.require(:user_name_form).permit(:name)
  end
end
