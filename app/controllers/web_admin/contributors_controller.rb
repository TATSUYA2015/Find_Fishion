class WebAdmin::ContributorsController < ApplicationController
  def index
    @contributors=Contributor.all
  end

  def show
    @contributor=Contributor.find(params[:id])
    @items=Item.all

  end

  def edit
    @contributor=Contributor.find(params[:id])
  end

  def update
    contributor=Contributor.find(params[:id])
    contributor.update(contributor_paramas)
    redirect_to web_admin_contributor_path
  end

  def followers
    contributor=Contributor.find(params[:id])
    @customers=contributor.followers
  end

  private

  def contributor_paramas
    params.require(:contributor).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :brand_name, :profile_image, :profile_image, :email, :postal_code, :address, :telephone_number, :is_deleted, :introduction)
  end

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction)
  end

end
