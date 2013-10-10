require 'will_paginate/array'

class RestaurantsController < ApplicationController
  include RestaurantsHelper
  before_action :require_login, only: [:new, :create, :edit, :destroy]

  def index
    if params[:search]
      @restaurants = Restaurant.search(params[:search]).includes(:dishes)
      @restaurants << Dish.search(params[:search]).pluck(:restaurant_id).uniq.map { |rest_id| Restaurant.find(rest_id) }
      @restaurants = @restaurants.flatten.uniq.paginate(:page => params[:page], :per_page => 24)

      if @restaurants.empty?
        flash[:error] = "Sorry no matches for '#{params[:search]}' were found"
      end
    else
      if logged_in? && current_user.restaurants.count > 0
        favorites = current_user.restaurants
        others = Restaurant.all - favorites
        @restaurants = (favorites + others).uniq.paginate(:page => params[:page], :per_page => 24)
      else
        @restaurants = Restaurant.all.paginate(:page => params[:page], :per_page => 24)
      end
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    new_rest = Restaurant.new(restaurant_attributes)
    if params[:restaurant][:name] != ""
      potential_url = potential(new_rest.name)
      new_rest.url = make_url(new_rest, potential_url)
      if new_rest.save
        flash[:success] = "Restaurant Added"
        redirect_to "/#{new_rest.url}/dishes"
      else
        flash[:error] = "Restaurant was not saved"
        render 'new'
      end
    else
      @restaurant = new_rest
      flash[:error] = "The Restaurant Needs a Name"
      render 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find_by_url(params[:restname].downcase)
    if @restaurant.nil?
      render 'not_found'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if params[:restaurant][:name] && params[:restaurant][:name] != @restaurant.name
      potential_url = potential(params[:restaurant][:name])
      @restaurant.url = make_url(@restaurant, potential_url)
    end
    @restaurant.update_attributes(restaurant_attributes)
    redirect_to "/#{@restaurant.url}/dishes"
  end

  def destroy
    @restaurant = Restaurant.find(params[:id]) if Restaurant.exists?(params[:id])
    if @restaurant
      @restaurant.destroy
      flash[:success] = "Restaurant Deleted"
    else
      flash[:error] = "Restaurant Was Not Found"
    end
    redirect_to '/restaurants'
  end

  def desc
    @rest = Restaurant.find_by_url(params[:restname])
    render 'desc', :layout => false
  end

  def coords
    @rest = Restaurant.find_by_url(params[:restname])
    coords = coords_hash(@rest)
    render :json => coords
  end

  def setcoords
    if params[:url]
      rest = Restaurant.find_by_url(params[:url])
      rest.update_attributes(:latitude => params[:lat], :longitude => params[:lon])
      render json: rest
    end
  end

  private
  
  def restaurant_attributes
    params.require(:restaurant).permit(:name, :address, :city, :state, :zip, :latitude, :longitude, :url, :cuisine)
  end
end