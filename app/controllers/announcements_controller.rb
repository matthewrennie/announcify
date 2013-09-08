class AnnouncementsController < ApplicationController

	before_filter :authenticate_user!

  def new
  	@announcement = Announcement.new
  end

  def edit
  end

  def create

  	@announcement = Announcement.new(announcement_params)
  	@announcement.user = current_user

  	# attempt to save the announcement
  	if @announcement.save
      redirect_to @announcement
    else
      render "new"
    end
  end

  def announcement_params
    params.require(:announcement).permit(:name, :description, :is_active, :trigger_page, :trigger_event, :content, :announcement_type, :position, :color, :is_dismissable, :active_until)
  end
end
