# app/controllers/api/v1/restaurants_controller.rb
class Api::V1::RestaurantsController < Api::V1::BaseController
  include Pundit
  acts_as_token_authentication_handler_for User, except: %i[index show]
  before_action :set_restaurant, only: %i[show update]

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show; end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def render_error
    render json: {
      errors: @restaurant.errors.full_messages
    }, status: :unprocessable_entity
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant # For Pundit
  end
end
