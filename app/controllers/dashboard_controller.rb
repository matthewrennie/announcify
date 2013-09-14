class DashboardController < ApplicationController

	before_filter :authenticate_user!

  def show

    active_announcements = []
    inactive_announcements = []
    n_impressions = 0
    n_clicks = 0

    # count the impressions, clicks and seperate active from inactive
    current_user.announcements.each {|announcement|
      n_impressions += announcement.announcement_impressions.count
      n_clicks += announcement.announcement_clicks.count
      if(announcement.is_active?)
        active_announcements << announcement
      else
        inactive_announcements << announcement
      end
    }

    # count the number of events processed
    n_events = current_user.events.count

    @summary = {}
    @summary['n_impressions'] = n_impressions
    @summary['n_clicks'] = n_clicks
    @summary['n_events'] = n_events
    @summary['active_announcements'] = active_announcements
    @summary['inactive_announcements'] = inactive_announcements

    respond_to do |format|
      format.html
      format.xml { render :xml => @summary.to_xml }
      format.json { render :json => @summary.to_json }
    end
  	  	
  end


end
