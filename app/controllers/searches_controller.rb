class SearchesController < ApplicationController

  def search
    @range = params[:range]
    search = params[:search]
    @word = params[:word]
    if @range == '1'
      @recipes = Recipe.search(search,@word)
    else
      @users = User.search(search,@word)
    end
  end

end
