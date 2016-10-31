include ApplicationHelper##Listing 8.34: Adding a helper method and a custom RSpec matcher

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end



def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

#to park this method called full title  under spec/support/utilities because it serves as a supporting method so that the spec test examples know what is method full_title..



def sign_in(user, options={}) 
 #The method is to visit the signin page and submit valid information
  if options[:no_capybara]

    # Sign in when not using Capybara.
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end