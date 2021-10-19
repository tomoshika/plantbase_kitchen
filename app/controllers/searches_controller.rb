class SearchesController < ApplicationController

  def search
    @range = params[:range]
    search = params[:search]
    @word = params[:word]
    if @range == '1'
      @recipe = Recipe.search(search,@word)
    else
      @user = User.search(search,@word)
    end
  end

end
