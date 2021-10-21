class HomesController < ApplicationController
  def top
    @recipes = Recipe.page(params[:page]).reverse_order.per(12)
  end

  def about
  end

end
