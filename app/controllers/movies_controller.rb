#Partners: davgao@berkeley.edu, 
class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :ratings, :sort_by, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    
  end

  def index
    @sort = params[:sort_by]
    @selected_ratings = params[:ratings]
    
    # Add to session if not nil
    if @selected_ratings
      session[:ratings] = @selected_ratings
    end
    if @sort
      session[:sort] = @sort
    end
    #byebug
    
    
    # if session.include? :ratings and !@selected_ratings and !@sort # use ratings from session
    #   #@movies = Movie.where({:rating => session[:selected_ratings].keys}).order(@sort)
    #   @selected_ratings = session[:ratings]
    #   @sort = session[:sort]
    #   redirect_to movies_path({sort_by: @sort, ratings: @selected_ratings})
    #   # else
    # end
    
    if session.include? :ratings and params[:ratings].nil?
      @selected_ratings = session[:ratings]
      if !params.include? :sort_by
        @sort = session[:sort]
      end
      # params[:ratings] = @selected_ratings
      # redirect_to movies_path(params)
      redirect_to movies_path({sort_by: @sort, ratings: @selected_ratings})

    end
    
    # Sort by @sort if not nilc
    
    # if @selected_ratings and @sort
    #   @movies = Movie.where({:rating => @selected_ratings.keys}).order(@sort)
    # end
    
    if @sort
      @movies = Movie.order(@sort)
    end
    
    if @selected_ratings
      @movies = Movie.where({:rating => @selected_ratings.keys}).order(@sort)
      
    else 
        @movies = Movie.all.order(@sort)
    end
    
      
    # # Filter by ratings if not nil
    # if @selected_ratings
    # end 
    
    # if @sort and @selected_ratings
      
    # else

    # end
    
    @all_ratings = Movie.list_all_ratings

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
  
end
