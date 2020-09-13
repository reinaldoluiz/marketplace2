class OrdersController < ApplicationController
  
  def index
    @orders = Order.all
    @products = Product.all
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new()
    @order.product = params[:product_id]
    @order.user = current_user
    @order.comment = Comment.new(user: @order.user, text:"Para começar o negócio crie um comentário",negociation: true )
    @order.save!
    render :show
  end
end