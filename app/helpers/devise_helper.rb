module DeviseHelper

  def devise_error_messages!
  	# Method code adapted from: # Gottfrois, P (2013) Devise Error Messages Twitter Bootstrap Style [Source code]. # https://coderwall.com/gottfrois
  	return '' if resource.errors.empty?  	
  	
  	messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-danger">     	
      <h4><span class="glyphicon glyphicon-ban-circle"></span>&nbsp;#{sentence}</h4>
      <ul>
      	#{messages}
    	</ul>
    </div>
    HTML

    html.html_safe

  end

  def devise_flash_messages!
  	return '' if flash.empty?

  	if(!flash[:alert].nil?)

  		html = <<-HTML
	    <div class="alert alert-danger">
				<span class="glyphicon glyphicon-ban-circle"></span>
				#{flash[:alert]}
			</div>
	    HTML

    	return html.html_safe

  	elsif(!flash[:notice].nil?)

  		html = <<-HTML
	    <div class="alert alert-warning">
				<span class="glyphicon glyphicon-warning-sign"></span>
				#{flash[:notice]}
			</div>
	    HTML

    	return html.html_safe

  	end

  end


end