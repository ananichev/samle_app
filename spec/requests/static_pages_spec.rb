require 'spec_helper'

describe "StaticPages" do
	
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
	
  describe "Home pages" do
  	
  	it "should have the content 'Sample App'" do
  	  visit "/static_pages/home"
  	  expect(page).to have_content('Sample App')
  	end
  	
  	it "should have the base title'" do
  	  visit '/static_pages/home'
  	  expect(page).to have_title("#{base_title}")
  	end
  	
  	it "should not have the title 'Home'" do
  	  visit "/static_pages/home"
  	  expect(page).not_to have_title("| Home")
  	end
  	
  end
  
  describe "Help pages" do
  	
  	it "should have the content 'Help'" do
  	  visit '/static_pages/help'
  	  expect(page).to have_content('Help')
 	end
 	
 	it "should have the title 'Help'" do
 	  visit "/static_pages/help"
 	  expect(page).to have_title("#{base_title} | Help")
 	end 
 		
  end
  
  describe "About pages" do
  	
  	it "should have the content 'About'" do
  	  visit '/static_pages/about'
  	  expect(page).to have_content('About')
  	end
  	
  	it "should have the title 'About'" do
  	  visit '/static_pages/about'
  	  expect(page).to have_title("#{base_title} | About")
  	end  	
  	
  end
  
  describe "Contact pages" do
  	
  	it "should have the content 'Contact'" do
  	  visit '/static_pages/contact'
  	  expect(page).to have_content('Contact')
  	end
  	
  	it "should have the title 'Contact'" do
  	  visit "/static_pages/contact"
  	  expect(page).to have_title("#{base_title} | Contact")
  	end
  	
  end
  
end
