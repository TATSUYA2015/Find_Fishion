class WebAdmin::GenresController < ApplicationController
  def index
    @genre=Genre.new
    @genres=Genre.all
  end

  def create
    @genre=Genre.new(genre_params)
    @genres=Genre.all
    if @genre.save
      redirect_to web_admin_genres_path
    else
      render :index
    end
  end

  def edit
    @genre=Genre.find(params[:id])
  end

  def update
    genre=Genre.find(params[:id])
    genre.update(genre_params)
    redirect_to web_admin_genres_path(genre.id)
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
