class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:new, :edit, :destroy]
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    prototype = Prototype.create(prototype_params)
    if prototype.save
      redirect_to root_path
    else
      @prototype = Prototype.new
      render action: :new
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
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if prototype.update(prototype_params)
      redirect_to prototype_path(params[:id])
    else
      @prototype = prototype
      render action: :edit
    end
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    @prototypes = Prototype.all
    render action: :index
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in? == current_user.id
      redirect_to action: :index
    end
  end
end
