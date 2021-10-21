class HomesController < ApplicationController
  def top
    @recipes = Recipe.all
    @recipes = Recipe.page(params[:page]).reverse_order
  end

  def about
  end

end
