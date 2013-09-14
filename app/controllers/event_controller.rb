class EventController < ApplicationController

	before_filter :authenticate_user!

  def index
  	@events = current_user.events.paginate(page:params[:page]).order('timestamp DESC')
  end

end
