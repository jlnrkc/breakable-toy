class PetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :authorize_user, only: [:destroy]

  def search
    @results = Pet.where("name ILIKE ?", "%#{params[:q]}%")
    render :search
  end

  def index
    @pet = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      flash[:notice] = "Pet added successfully"
      redirect to pet_path(@pet)
    else
      flash[:error] = @pet.errors.full_messages.join(",")
      render :new
    end
  end

  def destroy
   @pet = Pet.find(params[:id])
   @pet.destroy
   flash[:notice] = "Pet record deleted successfully"
   redirect_to pets_path
 end
end

private

def pet_params
  params.require(:pet).permit(
    :type,
    :breed,
    :age,
    :name,
    :description
  )
end