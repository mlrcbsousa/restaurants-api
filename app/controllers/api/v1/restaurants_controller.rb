# app/controllers/api/v1/restaurants_controller.rb
class Api::V1::RestaurantsController < Api::V1::BaseController
  include Pundit
  acts_as_token_authentication_handler_for User, except: %i[index show]
  before_action :set_restaurant, only: %i[show update destroy]

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show; end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant
    if @restaurant.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
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

# sample curl update
# curl -i -X PATCH                                        \
#        -H 'Content-Type: application/json'              \
#        -H 'X-User-Email: cherilynkrajcik@littel.io'     \
#        -H 'X-User-Token: g7jMu3Adat-HFuzbNjEG'          \
#        -d '{ "restaurant": { "name": "New name" } }'    \
#        http://localhost:3000/api/v1/restaurants/57

# sample curl post
# curl -i -X POST                                                              \
#      -H 'Content-Type: application/json'                                     \
#      -H 'X-User-Email: cherilynkrajcik@littel.io'                            \
#      -H 'X-User-Token: g7jMu3Adat-HFuzbNjEG'                                 \
#      -d '{ "restaurant": { "name": "New restaurant", "address": "Paris" } }' \
#      http://localhost:3000/api/v1/restaurants

# sample curl delete
# curl -i -X DELETE                                 \
#      -H 'X-User-Email: cherilynkrajcik@littel.io' \
#      -H 'X-User-Token: g7jMu3Adat-HFuzbNjEG'      \
#      http://localhost:3000/api/v1/restaurants/68
