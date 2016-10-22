def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

#to park this method called full title  under spec/support/utilities because it serves as a supporting method so that the spec test examples know what is method full_title..