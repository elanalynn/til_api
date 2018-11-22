class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = Item.all
    json_response(@items)
  end

  def create
    @item = Item.create!(item_params)
    json_response(@item, :created)
  end

  def show
    json_response(nil, :not_found) if @item.nil?
    json_response(@item)
  end

  def update
    @item.update(item_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def item_params
    params.permit(:content, :date, :user_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end