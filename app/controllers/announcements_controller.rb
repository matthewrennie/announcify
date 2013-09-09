class AnnouncementsController < ApplicationController

	before_filter :authenticate_user!

  def new
  	@announcement = Announcement.new
    @announcement.is_active = true
    define_view_requirements()    
    @new = true
  end

  def create

    @announcement = Announcement.new(announcement_params)
    @announcement.user = current_user

    # attempt to save the announcement
    if @announcement.save
      redirect_to root_path
    else
      define_view_requirements()
      @new = true
      render "new"
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])   
    define_view_requirements()
  end

  def update
    # update the announcement
    @announcement = current_user.announcements.find(params[:id])
    if @announcement.update(announcement_params)
      redirect_to root_path
    else      
      define_view_requirements()
      render "edit"
    end
  end

  def destroy
    @announcement = current_user.announcements.find(params[:id])
    @announcement.destroy
    redirect_to root_path
  end

  def define_view_requirements(selected_position_name=nil)
    @customer_segments = current_user.customer_segments
    @events = distinct_user_events()
    @positions = [['Top', 1], ['Bottom', 2], ['Left', 3], ['Right', 'right'], ['Top Left', 'top-left'], ['Center', 'center'], ['Top Right', 'top-right'], ['Bottom Left', 'bottom-left'], ['Bottom Right', 'bottom-right']]

    # specific the selected positions
    @selected_position_idx = 1
    if(!selected_position_name.nil?)
    end
  end

  def distinct_user_events
    p 'one'
    events = []
    current_user.customers.each { |customer|  
      events << customer.events.uniq{|event| event.name}
    }
    p 'two'
    p events.length
    events.flatten.uniq{|event| event.name}.sort {|x,y| x.name <=> y.name }  
  end

  def announcement_params
    params.require(:announcement).permit(:name, :description, :is_active, :trigger_page, :trigger_event, :content, :announcement_type, :position, :color, :is_dismissable, :active_until)
  end
end
