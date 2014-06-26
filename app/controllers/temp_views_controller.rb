class TempViewsController < ApplicationController
  def messages_index
  end

  def messages_show
  end

  def offers_index
  end

  def offers_show
  end

  def profile
  end

  def user_marketplace
    @categories = Category.includes(:subcategories).order(id: :asc)
  end
end