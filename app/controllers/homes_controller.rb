class HomesController < ApplicationController
  def top
    @recipes = Recipe.all
    @recipes = Recipe.all.order(created_at: :desc)
  end

  def about
  end

end
