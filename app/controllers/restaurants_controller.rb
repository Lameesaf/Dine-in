class RestaurantsController < ApplicationController
    before_action   :is_admin  , only: [:new, :create, :edit, :update, :destroy]

    def index 
    @role= current_user.Role
    @restaurants = Restaurant.all    
    end

    def show 
    @restaurant = Restaurant.find(params[:id])
    end

    def new
        @role= current_user.Role
        @restaurant = Restaurant.new

        # @restaurant_id = params
    end

    def create
        @role= current_user.Role
        # params[:reservation][:restaurant_id]= 2
        

        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.save
        redirect_to @restaurant
    end
    
    def edit
        @role= current_user.Role
        @restaurant = Restaurant.find(params[:id])
    end

    def update
        @role= current_user.Role
        @restaurant = Restaurant.find(params[:id])
        @restaurant.update(restaurant_params)
        redirect_to @restaurant
    end
    
    def destroy
        Restaurant.find(params[:id]).destroy
        redirect_to restaurants_path
    end
    
    private
    def restaurant_params
        params.require(:restaurant).permit(:name,:category, :user_id, :image)
    end

    def is_admin
      if  current_user.Role =='admin'
        return true
      end
      redirect_to restaurants_path
    end
end
