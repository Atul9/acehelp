# frozen_string_literal: true

class UrlController < ApplicationController
  include LoadOrganization

  before_action :load_url, only: %i[update destroy]

  def index
    urls = @organization.urls
    render json: urls, root: "urls"
  end

  def create
    url = @organization.urls.new(url_params)

    if url.save
      render json: { message: "Url created successfully" }
    else
      render_unprocessable_entity "Bad Request"
    end
  end

  def update
    if @url.update(url_params)
      render json: { message: "url updated successfully" }
    else
      render_unprocessable_entity "Bad Request"
    end
  end

  def destroy
    if @url.destroy
      render json: { message: "url deleted successfully" }
    else
      render_unprocessable_entity "Bad Request"
    end
  end

  private

    def load_url
      @url = Url.find_by!(id: params[:id], organization_id: @organization.id)
    end

    def url_params
      params.require(:url).permit(:url)
    end
end