class HomeController < ApplicationController
  def index
  end

  def search 
    @products = Product.where('name like ? OR category like ?', "%#{params[:q]}%", "%#{params[:q]}%")
  end
end