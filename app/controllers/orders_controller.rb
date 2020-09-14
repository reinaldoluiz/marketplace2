class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = Order.all
    @products = Product.all
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create
    @order = Order.new()
    @order.product_id = params[:product_id]
    @order.user = current_user
    @order.save!
    render :show
  end
end