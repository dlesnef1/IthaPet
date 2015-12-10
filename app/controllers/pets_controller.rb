class PetsController < ApplicationController
    include PetsHelper

    before_action :logged_in_user, only: [:edit]
    before_action :correct_user,   only: [:edit]

    def index
        @pets = Pet.paginate(page: params[:page])
    end

    def show
        @pet = Pet.find(params[:id])
    end

    def update
        @pet = Pet.find(params[:id])
        if params[:adopt] == "TRUE"
            @pet.update(user: current_user)
            render "show"
        elsif !params[:adopt].empty?
            message = interact(@pet, params[:adopt])

            if message != "nothing"
                flash[:danger] = message
                redirect_to '/'
                return
            end

            render "edit"
        else
            flash[:danger] = "Something went wrong!"
            redirect_to '/'
        end
    end

    def edit
        @pet = Pet.find(params[:id])
    end

    # Just for us to easily add pets
    def new
        @pet = Pet.new
    end

    def create
        @pet = Pet.new(pet_params)
        @pet.update(hungriness: 0, happiness: 100, cleanliness: 50, loyalty: 50)
        if @pet.save
            flash[:success] = "Added pet successfully!"
            redirect_to @pet
        else
        render 'new'
        end
    end

    private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
        @pet = Pet.find(params[:id])
        unless current_user == @pet.user
            flash[:danger] = "Not your pet!"
            redirect_to login_url
        end
    end

    def pet_params
      params.require(:pet).permit(:name, :biography, :image)
    end
end
