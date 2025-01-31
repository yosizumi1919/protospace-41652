class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:create,:edit,:destroy]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
   @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      @Prototypes = Prototype.includes(:user)
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
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
  end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
   params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end
  
end





