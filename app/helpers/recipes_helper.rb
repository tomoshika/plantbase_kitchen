module RecipesHelper
  
  #ハッシュタグのヘルパーメソッド
  def render_with_hashtags(memo)
    memo.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/recipe/hashtag/#{word.delete("#")}"}.html_safe
  end
  
end
