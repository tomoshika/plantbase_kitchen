class SearchesController < ApplicationController

  def search
    @range = params[:range]
    search = params[:search]
    @word = params[:word]
    @tags = Hashtag.all
    if @range == '1'
      @recipes = Recipe.search(search,@word).page(params[:page]).reverse_order.per(6)
    else
      @users = User.search(search, @word).page(params[:page]).reverse_order.per(6)
    end
  end

end
