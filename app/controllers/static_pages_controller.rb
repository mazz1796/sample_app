class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @micropost = current_user.microposts.build  #Associate with _micropost_form.html.erb.ところでここのロジックの（流れ）はviews/static_pages/homeに行った後、homeのなかで<%= render 'shared/micropost_form' %>が呼ばれてそのなかの@micropostがここにくる。
  	 @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact

  end
end
