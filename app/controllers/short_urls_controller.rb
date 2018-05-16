class ShortUrlsController < ApplicationController
  def new
    @short_url = ShortUrl.new
  end

  def create

    @short_url = ShortUrl.new(base_url: params[:base_url])

    if !@short_url.valid?
      flash.now[:error] = "URL is invalid!. Please provide a proper url."
      render 'new'
      return
    end

    @short_url2 = ShortUrl.find_by_base_url(@short_url.base_url)

    if @short_url2.present?
      flash[:notice] = "URL has already been shortened before. Please find details below."
      redirect_to :action => "show", base_url: @short_url.base_url
    end
  end

  def show
    if params[:base_url].present?
      @short_url = ShortUrl.find_by_base_url(params[:base_url])
    else
      flash[:notice] = "Parameters not found, please try again."
      redirect_to :action => "new"
    end
  end

end
