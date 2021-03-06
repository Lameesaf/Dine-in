class RestaurantsController < ApplicationController
    before_action   :is_admin  , only: [:new, :create, :edit, :update, :destroy]
    # Show all restaurants (Seen by guest and admin)
    def index 
        if user_signed_in?
    @role= current_user.Role
        end
    @restaurants = Restaurant.all    
    end

    def show 
        if user_signed_in?
        @role=current_user.Role
        end
        @restaurant = Restaurant.find(params[:id])
    end
    # Add restaurant(Done by Restaurant manager and admin : Exclaimer 1 Restaurant per 1 Restaurant manager)
    def new
        @role= current_user.Role
        @restaurant = Restaurant.new
    end

    def create
        
        @role= current_user.Role
        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.save
        @user =User.find(@restaurant.user_id)
        @user.Role="manger"
        @user.save
        redirect_to @restaurant
    end
    # Edit restaurant information(Done by Restaurant manager and admin)
    def edit
        @role= current_user.Role
        @restaurant = Restaurant.find(params[:id])
    end

    def update
        @role= current_user.Role
        @restaurant = Restaurant.find(params[:id])
        @restaurant.update(restaurant_params)
        @user =User.find(@restaurant.user_id)
        @user.Role="manger"
        @user.save
        redirect_to @restaurant
    end
    #  Deleting restaurant (Done by Restaurant manager and admin)
    def destroy
        @user =User.find(Restaurant.find(params[:id]).user_id)
        @user.Role="customer"
        @user.save
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
    def is_manger
        if  current_user.Role =='manger'
          return true
        end
        redirect_to restaurants_path
      end
end
