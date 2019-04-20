# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    # Initialize variable movies ordering by title ascending by default
    @movies = Movie.order("#{sort_column} #{sort_direction}")

    # Apply rating filter only if there is a filter, so no need to set all
    # checkboxes checked in order display all movies by default
    @movies = @movies.rating(params[:ratings].keys) if params[:ratings].present?
  end

  def show
    id = params[:id]
    @movie = Movie.find(id)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created!"
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def edit
    id = params[:id]
    @movie = Movie.find(id)
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated!"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find params[:id]
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted!"
    redirect_to movies_path
  end

  private

  # Method to sort column on click, accepting only title & release date in order
  # to avoid SQL injection. Defaults to title
  def sort_column
    Movie.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  # Method to set column sorting direction on click, accepting only "asc" and
  # "desc" to avoid SQL injection. Defaults to "asc"
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end