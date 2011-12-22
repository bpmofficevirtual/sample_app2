require 'spec_helper'

describe "Layout Links" do

# Gerado automaticamente:
#
#  describe "GET /layout_links" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you #want to use webrat methods/matchers
#      get layout_links_index_path
#      response.status.should be(200)
#    end
#  end

 # Testes de INTEGRAÇÃO

 it "should have a Home page at '/'" do
   get '/'
   response.should have_selector('title', :content => "Home")
 end

 it "should have a Contact page at '/contact'" do
   get '/contact'
   response.should have_selector('title', :content => "Contact")
 end

 it "should have a About page at '/about'" do
   get '/about'
   response.should have_selector('title', :content => "About")
 end
 
 it "should have a Help page at '/help'" do
   get '/help'
   response.should have_selector('title', :content => "Help")
 end

 it "should have a Sign Up page at '/signup'" do
   get '/signup'
   response.should have_selector('title', :content => "Sign Up")
 end

 # TESTES para Links do layout
 it "should have the right links on the layout" do
   visit root_path
   click_link "About"
   response.should have_selector('title', :content => "About")
   click_link "Help"
   response.should have_selector('title', :content => "Help")
   click_link "Contact"
   response.should have_selector('title', :content => "Contact")
   click_link "Home"
   response.should have_selector('title', :content => "Home")
   click_link "Sign up now!"
   response.should have_selector('title', :content => "Sign Up")

 end

 #######################################

 describe "when not signed in" do
    it "should have a signin link" do
       visit root_path
       response.should have_selector("a", :href => signin_path,
				          :content => "Sign in")
    end
 end

## Layout Links when signed in should have a signout link
##
##     Failure/Error: response.should have_selector
## ("a", :href => signout_path, :content => "Sign out")
##     expected following output to contain a <a href='
##   /signout'>Sign out</a> tag:
##
## Layout Links when signed in should have a profile link
##

describe "when signed in" do
    
    before(:each) do 
       visit signin_path		## 1o)
       @user = Factory(:user,  :email => Factory.next(:email)) ## 2o)
       fill_in "Email",        :with => @user.email
       fill_in "Password",     :with => @user.password
       click_button
    end

    it "should have a signout link" do 
        visit root_path
        response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end

    it "should have a profile link" do
       visit root_path
       response.should have_selector("a", :href => user_path(@user), :content => "Profile")
    end

 end
end
