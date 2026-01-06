require "json"

class LinkController < ActionController::Base
  allow_browser versions: :modern
  protect_from_forgery with: :null_session

  def test
    render json: {status: "ok", code: 200, message: "Welcome to your links."}
  end

  # list all links
  def list
    @links = Link.all()
    render json: @links
  end

  # create a new link obj
  def create
    @link = Link.new(create_link_params)
    puts @link
    
    if @link.save
      render json: { status: "ok", code: 201, data: @link }
    else
      render json: { status: "failed", code: 400, message: "failed to create a link" }
    end
  end

  private

  def create_link_params
    params.require(:link).permit(:url, :title, :note, :last_resurfaced_at, :archived)
  end
end