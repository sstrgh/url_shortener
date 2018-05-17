class ShortUrlsController < ApplicationController
  def new
    @short_url = ShortUrl.new
  end

  def create

    # Checks if the url is a valid url
    @short_url = ShortUrl.new(base_url: params[:base_url])
    if !@short_url.valid?
      flash.now[:error] = "URL is invalid!. Please provide a proper url."
      render 'new'
      return
    end

    # Checks if the url to be shortened already exists
    @searched_short_url = ShortUrl.find_by_base_url(@short_url.base_url)
    if @searched_short_url.present?
      flash[:notice] = "URL has already been shortened before. Please find details below."
      redirect_to :action => "show", base_url: @short_url.base_url
      return
    end

    # Generates short url and if saves, redirects to show page
    @short_url.generate_short_url
    if @short_url.save
      flash[:success] = "Successfully shortened URL!"
      redirect_to :action => "show", base_url: @short_url.base_url
      return
    else
      flash[:error] = "Failed to shortened URL"
      redirect_to :action => "new"
    end

  end

  def show
    @short_url = ShortUrl.find_by_base_url(params[:base_url])

    respond_to do |format|
      format.html {
        # Reroutes back to new if the base_url is not found
        if !@short_url.present?
          flash[:notice] = "URL not found, please try again."
          redirect_to :action => "new"
        end
      }
      format.json {
        render json: @short_url
      }
    end

  end


  # Redirects to base_url if the shortened_url is appended directly to the host
  # Todo:
  # Integrations tests for external link routing on capybara is configuration heavy
  # Given the time contraints and the objective of this exercise, I've decided to skip it.
  def reroute
    @short_url = ShortUrl.find_by_shortened_url(params[:short_url])
    if @short_url.present?
      @short_url.total_visits += 1
    else
      flash[:error] = "URL not found, please try again."
      redirect_to :action => "new"
      return
    end

    if @short_url.save
      redirect_to @short_url.base_url
      return
    end

  end

end
