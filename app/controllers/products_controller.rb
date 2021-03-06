class ProductsController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show]
    
    def index
      @products = Product.all.reject{|product| product.user.company != current_user.company }
    end
  
    def show
      @product = Product.find(params[:id])
    end
  
    def new
      @product = Product.new
    end
    
    def create
      @product = Product.new(product_params)
      @product.user = current_user
      @product.save!
      redirect_to @product, notice:'Produto criado com sucesso' 
    end
  
    private
    def product_params
      params.require(:product).permit(:name, :category,:price, :description, :image)
    end
  end