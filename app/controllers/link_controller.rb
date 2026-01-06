require "json"

class LinkController < ActionController::Base
  allow_browser versions: :modern
  protect_from_forgery with: :null_session

  def test
    render json: {status: "ok", code: 200, message: "Welcome to your links."}
  end

  # list all links
  def all
    @links = Link.all()
    render json: @links
  end

  # fetch a particular link record as per its id
  def fetch
    @link = Link.find(params[:id])
    if @link
      render json: { code: 200, data: @link}
    else
      render json: { code: 404, message: "Link not found for id #{params[:id]}" }
    end
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
  
  # delete a link record as per the id
  def delete
    @link = Link.find_by(id: params[:id])
    
    if @link.destroy
      render json: { status: 'ok', code: 204, message: 'deleted successfully' }
    else
      render json: { status: 'failed', code: 400, message: "failed to delete link with id: #{params[:id]}"}
    end
  end

  private

  def create_link_params
    params.require(:link).permit(:url, :title, :note, :last_resurfaced_at, :archived)
  end
end
