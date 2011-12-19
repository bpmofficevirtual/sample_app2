require 'spec_helper'

describe PagesController do

  render_views

  before (:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
   
    it "should have the right title" do
       get 'home'
       response.should have_selector("title", :content => @base_title + " | Home")
    end

    it "should not have 'sign up' when loged" do
       user = Factory(:user)
       test_sign_in(user)
       get 'home'
       response.should_not have_selector('a', :href => signup_path,
                                              :content => "Sign up")
    end
 
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
       get 'contact'
       response.should have_selector("title", :content => @base_title + " | Contact")
    end

  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
       get 'about'
       response.should have_selector("title", :content => @base_title + " | About")
    end

  end

  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
       get 'help'
       response.should have_selector("title", :content => @base_title + " | Help")
    end

  end
 

end
