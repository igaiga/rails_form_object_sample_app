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

    respond_to do |format|
      if @name.save
        format.html { redirect_to user_url(@name.user), notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /names/1
  def update
    @name = UserNameForm.new(model: User.find(params[:id]), **name_params)

    respond_to do |format|
      if @name.save
        format.html { redirect_to user_url(@name.user), notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def name_params
    params.require(:user_name_form).permit(:name)
  end
end
