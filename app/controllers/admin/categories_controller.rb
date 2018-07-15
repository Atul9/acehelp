# frozen_string_literal: true

class Admin::CategoriesController < ApplicationController
  before_action :ensure_user_is_logged_in, :set_organization

  def index
    render
  end

  def new
    render
  end
end
