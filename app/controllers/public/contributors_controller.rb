class Public::ContributorsController < ApplicationController
  def show
    @contributor=Contributor.find(params[:id])
    @items=Item.page(params[:page])
  end

  def followers
    contributor = Contributor.find(params[:id])
    @customer = contributor.followers
  end


  private

  def contributor_paramas
    params.require(:contributor).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :brand_name, :get_profile_image, :profile_image, :email, :postal_code, :address, :telephone_number, :introduction)
  end

end
