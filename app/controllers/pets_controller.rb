class PetsController < ApplicationController
    def index
        @pets = Pet.paginate(page: params[:page])
    end

    def show
        @pet = Pet.find(params[:id])
    end


    def update
        @pet = Pet.find(params[:id])
        if @pet.update_attributes(pet_params)
            redirect_to @pet
        else
            render 'edit'
        end
    end

    private

    def pet_params
      params.require(:pet).permit(:name, :image, :user)
    end
end
