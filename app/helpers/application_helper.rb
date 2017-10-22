module ApplicationHelper
  # def hidden_div_if(condition, attributes = {}, &block)
  #   if condition
  #     attributes["style"] = "display: none"
  #   else
  #     content_tag("div", attributes, &block)
  #   end
  # end

  def get_page_views
  	byebug
    page_location = request.env['REQUEST_URI']
    if cookies.has_key?(page_location)
      cookies[page_location] = cookies[page_location].to_i + 1
  	else
  	  cookies[page_location] = { value: 1, expires: 1.year.from_now }
  	end
  	cookies[page_location]
  end
end
