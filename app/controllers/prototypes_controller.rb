class PrototypesController < ApplicationController


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

 def create
  @prototype = current_user.prototypes.build(prototype_params)

  if @prototype.save
    redirect_to prototypes_url, notice: "Prototype was successfully created."
  else
    render :new, status: :unprocessable_entity
  end
end

def show
  @prototype = Prototype.find(params[:id])
  @comment = Comment.new
  @comments = @prototype.comments
end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: "Prototype was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy

    redirect_to prototypes_url, notice: "Prototype was successfully destroyed."
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :content, :image).merge(user_id: current_user.id)
  end




end
