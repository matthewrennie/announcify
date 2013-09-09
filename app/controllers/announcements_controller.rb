class AnnouncementsController < ApplicationController

	before_filter :authenticate_user!

  def new
  	@announcement = Announcement.new
    @announcement.is_active = true
    @customer_segments = current_user.customer_segments
    @events = distinct_user_events()  
  end

  def create

    @announcement = Announcement.new(announcement_params)
    @announcement.user = current_user

    # attempt to save the announcement
    if @announcement.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])   
    @customer_segments = current_user.customer_segments
    @events = distinct_user_events()    
  end

  def update
    # attempt to save the announcement
    # if @announcement.save
    #   redirect_to root_path
    # else
    #   render "edit"
    # end
  end  

  def distinct_user_events
    events = []
    current_user.customers.each { |customer|  
      events << customer.events.uniq{|event| event.name}
    }
    events.flatten.uniq{|event| event.name}.sort {|x,y| x.name <=> y.name }  
  end

  def announcement_params
    params.require(:announcement).permit(:name, :description, :is_active, :trigger_page, :trigger_event, :content, :announcement_type, :position, :color, :is_dismissable, :active_until)
  end
end
