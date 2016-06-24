class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    @movies = @movies.title_director_filter(params[:key_word].strip) if params[:key_word]

    case params[:duration]
    when 'Under 90 minutes'
      @movies = @movies.where('release_date < ?', 90)
    when 'Between 90 and 120 minutes'
      @movies = @movies.where(release_date: 90..120)
    when 'Over 120 minutes'
      @movies = @movies.where('release_date > ?', 120)
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "You've deleted the movie - #{@movie.title}."
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :remote_image_url, :description
    )
  end
end
