require 'spec_helper'

describe "StaticPages" do
	
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  
  subject { page }
  
  describe "Home pages" do
  	
  	before { visit root_path }
  	
  	it { should have_content('Sample App') }
  	it { should have_title("#{base_title}") }
  	it { should_not have_title("| Home") }
  	
  end
  
  describe "Help pages" do
  	
  	it "should have the content 'Help'" do
  	  visit help_path
  	  expect(page).to have_content('Help')
 	end
 	
 	it "should have the title 'Help'" do
 	  visit help_path
 	  expect(page).to have_title("#{base_title} | Help")
 	end 
 		
  end
  
  describe "About pages" do
  	
  	it "should have the content 'About'" do
  	  visit about_path
  	  expect(page).to have_content('About')
  	end
  	
  	it "should have the title 'About'" do
  	  visit about_path
  	  expect(page).to have_title("#{base_title} | About")
  	end  	
  	
  end
  
  describe "Contact pages" do
  	
  	it "should have the content 'Contact'" do
  	  visit contact_path
  	  expect(page).to have_content('Contact')
  	end
  	
  	it "should have the title 'Contact'" do
  	  visit contact_path
  	  expect(page).to have_title("#{base_title} | Contact")
  	end
  	
  end
  
end
