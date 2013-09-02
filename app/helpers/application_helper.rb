# Code adapted from:
# Hartl, M (2013) Ruby On Rails Tutorial - Source code listings (Version unknown) [Source code].
# http://ruby.railstutorial.org

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
