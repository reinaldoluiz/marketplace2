class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = Order.all.reject{|order| order.user_id != current_user.id && order.closed? || order.bought? }
    @products = Product.all
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new()
    @order.product_id = params[:product_id]
    @order.user = current_user
    @order.open!
    @order.save!
    render :show
  end
end