require 'spec_helper'

describe "Static pages" do #Static pageのRSpecを書きますよということ

  subject { page }

  describe "Home page" do #Home Pageのところはどんなstringでもいい"
    before { visit root_path }


    it { should have_content('Sample App') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }


    describe "for signed-in users" do  #A test for rendering the feed on the Home page.
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end

# require 'spec_helper'


# describe "Static pages" do

#   let(:base_title) { "Ruby on Rails Tutorial Sample App"}

#    describe "Home page" do
#   before { visit root_path }

#   it "should have the content 'Sample App'" do
#     expect(page).to have_content('Sample App')
#   end

#   it "should have the base title" do
#     expect(page).to have_title("Ruby on Rails Tutorial Sample App")
#   end

#   it "should not have a custom page title" do
#     expect(page).not_to have_title('| Home')
#   end
# end

#    describe "Help page" do

#     it "should have the content 'Help'" do
#       visit help_path
#       expect(page).to have_content('Help')
#     end

#     it "should have the title 'Help'" do
#       visit help_path
#       expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
#     end
#   end

#   describe "About page" do

#     it "should have the content 'About Us'" do
#       visit about_path
#       expect(page).to have_content('About Us')
#     end
#     it "should have the title 'About Us'" do
#       visit about_path
#       expect(page).to have_title("#{base_title}  | About Us")
#     end
#    end

#   describe "Contact page" do

#     it "should have the content 'Contact'" do
#       visit contact_path
#       expect(page).to have_content('Contact')
#     end
#     it "should have the title 'Contact'" do
#       visit contact_path
#       expect(page).to have_title("#{base_title} | Contact")
#     end
#    end




# end