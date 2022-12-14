class Public::ItemsController < ApplicationController
  def index
  end

  def show
    @item=Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:contributor_id, :genre_id, :name, :image, :introduction)
  end

end
