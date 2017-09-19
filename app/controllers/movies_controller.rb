class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    
  end

  def index
    # @all_ratings = Movie.list_all_ratings
    # ratings = params[:ratings].blank? ? [] : params[:ratings].keys
    # @movies = Movie.where({rating: ratings})
    @sort = params[:sort_by]
    @movies = Movie.order(sort).all
    #@movies = Movie.all

  end

  def new
    # default: render 'new' template
  end
 
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def sort
    # @all_ratings = Movie.list_all_ratings
    sort_by = params[:sort_by]
    @movies = Movie.order(sort_by)
    @sort_type = "title"
    render :index
  end
  
  def sort_rating
    # @all_ratings = Movie.list_all_ratings
    @movies = Movie.order(:rating)
    @sort_type = "rating"
    render :index
  end

end
