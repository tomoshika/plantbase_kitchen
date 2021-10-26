class SearchesController < ApplicationController

  def search
    @range = params[:range]
    search = params[:search]
    @word = params[:word]
    if @range == '1'
#     @recipes = Recipe.search(search,@word).page(params[:page]).reverse_order.per(12)
      redirect_to recipes_path(search: params[:search], word: params[:word])
    else
      @users = User.search(search,@word).page(params[:page]).reverse_order.per(12)
    end
  end

end
