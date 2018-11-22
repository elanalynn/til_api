module V1
  class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :update, :destroy]

    def index
      @tags = Tag.all
      json_response(@tags)
    end

    def create
      @tag = Tag.create!(tag_params)
      json_response(@tag, :created)
    end

    def show
      json_response(nil, :not_found) if @tag.nil?
      json_response(@tag)
    end

    def update
      @tag.update(tag_params)
      head :no_content
    end

    def destroy
      @tag.destroy
      head :no_content
    end

    private

    def tag_params
      params.permit(:label, :item_id)
    end

    def set_tag
      @tag = Tag.find(params[:id])
    end
  end
end
