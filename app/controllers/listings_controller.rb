class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: [:show]
  before_action :set_user_listing, only: [:edit, :update, :destroy]

  def index
      @listings = Listing.all
  end

  def show
      
  end

  def new
    @listing = Listing.new
    
  end

  

  def create
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture)
    
    @listing = current_user.listings.create(listing_params)
    @listing.save

    if @listing.save
      redirect_to @listing
    else
      render :new
    end

  end

  def edit
     
  end

  def update
    
    if @listing.update( listing_params )
      redirect_to @listing
    else 
      render :edit
    end
  end

  def destroy
      @listing.destroy
      redirect_to listings_path
  end

  

  private

  def set_listing
    id = params[ :id ]
    @listing = Listing.find( id )
  end

  def set_user_listing
    id = params[:id]
    @listing = current_user.listings.find_by_id( id )

    if @listing == nil
        redirect_to listings_path
    end
  end

  def listing_params
    params.require(:listing).permit( :title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture )
  end
end