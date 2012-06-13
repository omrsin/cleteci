module ApplicationHelper

	def full_title(page_title)
		base_title = "CLETECI"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
		
	end
	
	def content_box(url, name, imgClass, img, contentClass, text)
		header = content_tag :header do 
						 	 content_tag :h1, name 
						 end
		
		image = content_tag :div, class: "span1 #{imgClass}" do
							image_tag img, alt: name
						end
						
		content = content_tag :div, class: "span3 #{contentClass}" do
								content_tag :p, text
							end
		
		article = content_tag :div, class: "article-content" do
								image +
								content
							end
		
		link_to url do
			content_tag :article, class: "span4" do
				header +
				article
			end
		end
	end
	
end
