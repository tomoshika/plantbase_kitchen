class HomesController < ApplicationController
  def top
    @recipes = Recipe.page(params[:page]).reverse_order.per(12)
    @tags = Hashtag.all
  end

  def about
  end
end
