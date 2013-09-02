module ApplicationHelper
	
	# Returns the full title on a per-page basis.
	# http://ruby.railstutorial.org/chapters/rails-flavored-ruby#top
  def full_title(page_title)
    base_title = "Announcify"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
