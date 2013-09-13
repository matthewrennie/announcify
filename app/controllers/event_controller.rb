class EventController < ApplicationController

	before_filter :authenticate_user!

  def index
  	p current_user.events.count
  	@events = current_user.events.paginate(page:params[:page])
  	p @events.count
  end

end
