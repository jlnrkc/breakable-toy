class PetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :authorize_user, only: [:destroy]

  def search
    @pets = Pet.all
    @pets = @pets.where(animal_type: params[:animal_type]) if params[:animal_type].present?
    @pets = @pets.where("breed ILIKE ?", "%#{params[:breed]}%") if params[:breed].present?
    @pets = @pets.where(age: params[:age]) if params[:age].present?
    @pets = @pets.where(size: params[:size]) if params[:size].present?
    @pets = @pets.where(sex: params[:sex]) if params[:sex].present?
    @pets = @pets.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    @pets = @pets.where(location: params[:location]) if params[:location].present?
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
    :size,
    :sex,
    :name,
    :location,
    :description
  )
end
