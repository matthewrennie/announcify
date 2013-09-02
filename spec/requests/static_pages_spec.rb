require 'spec_helper'

describe "StaticPages" do
  
  describe "Home Page" do
    
    it "should have the content 'Announcify'" do
      visit '/static_pages/home'
      expect(page).to have_content('Announcify')
    end

    it "should have the right title" do
  		visit '/static_pages/home'
  		expect(page).to have_title("Announcify | Home")
		end

  end
  
  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "should have the right title" do
  		visit '/static_pages/help'
  		expect(page).to have_title("Announcify | Help")
		end

  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have the right title" do
  		visit '/static_pages/about'
  		expect(page).to have_title("Announcify | About Us")
		end

  end

end
