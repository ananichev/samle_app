require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }
  
  describe "signin page" do
  	
  	before { visit signin_path }
  	
  	it { should have_title("Sign in") }
  	it { should have_content("Sign in") }
  	
  	describe "with invalid information" do
  	  
  	  let(:submit) { "Sign in" }
  	  
  	  before { click_button submit }
  	  
  	  it { should have_error_message("Invalid") }
  	  it { should have_title("Sign in") }
  	  
  	end
  	
  	  describe "after visiting another page" do
  	  
  	    before { click_link "Home" }
  	  
  	    it { should_not have_error_message("Invalid") }
  		
  		
      end
  	
  	describe "with valid information" do
  		
  	  let(:user) { FactoryGirl.create(:user) }
  	  before { sign_in user }
  	  
  	  it { should have_title(user.name) }
  	  it { should have_link('Users',       href: users_path) }
  	  it { should have_link('Profile',     href: user_path(user)) }
  	  it { should have_link('Settings',    href: edit_user_path(user)) }
  	  it { should have_link('Sign out',    href: session_path(user.id)) }
  	  it { should_not have_link('Sign in', href: signin_path) }
  	  
  	  describe "followed by signout" do
  	  	before { click_link "Sign out" }
  	  	it { should have_link("Sign in") }
  	  end
  		
  	end
  	
  end
  
  describe "authorization" do
  	
  	describe "as non-admin user" do
  	  let(:user)      { FactoryGirl.create(:user) }
  	  let(:non_admin) { FactoryGirl.create(:user) }
  	  
  	  before { sign_in non_admin, no_capybara: true }
  	  
  	  describe "submitting a DELETE request to the Users#destroy action" do
  	  	before  { delete user_path(user) }
  	  	specify { expect(response).to redirect_to(root_url) }
  	  end
  	  
  	  describe "submitting a DELETE request to the User#destroy action" do
  	  	let(:admin) { FactoryGirl.create(:admin) }
  	  	before { sign_in admin, no_capybara: true }
  	  	before { delete user_path(admin) }  	  	
  	  	specify{ expect(response).to redirect_to(root_url) }
  	  	
  	  end
  	  
  	    	  
  	end 
  	
  	describe "for non-signed-in users" do
  	  let(:user) { FactoryGirl.create(:user) }
  	  
  	  describe "when attemting to visit a protected page" do
  	  	before do
  	  	  visit edit_user_path(user)
  	  	  fill_in "Email",    with: user.email
  	  	  fill_in "Password", with: user.password
  	  	  click_button "Sign in"
  	  	end
  	  	
  	  	describe "after signing in" do
  	  	  it "should render the desire protected page" do
  	  	  	expect(page).to have_title('Edit user')
  	  	  end
  	  	end
  	  	
  	  end
  	  
  	  describe "in the Users controller" do
  	  	
  	  	describe "visiting the edit page" do
  	  	  before { visit edit_user_path(user) }
  	  	  it { should have_title('Sign in') }
  	  	end
  	  	
  	  	describe "submitting to the update action" do
  	  	  before  { patch user_path(user) }
  	  	  specify { expect(response).to redirect_to(signin_path) }
  	  	end
  	  	
  	  	describe "visiting the user index" do
  	  	  before { visit users_path }
  	  	  it { should have_title("Sign in") }
  	  	end
  	  		
  	  end
  	  
  	  describe "as wrong user" do
  	    let(:user)       { FactoryGirl.create(:user) }
  	    let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
  	    before { sign_in user, no_capybara: true }
  	    
  	    describe "submitting a GET request to the User#edit action" do
  	      before  { get edit_user_path(wrong_user) }
  	      specify { expect(response.body).not_to match(full_title('Edit user')) }
  	      specify { expect(response).to redirect_to(root_url) }
  	    end
  	    
  	    describe "submitting a PATCH request to the User#update action" do
  	      before  { patch user_path(wrong_user) }
  	      specify { expect(response).to redirect_to(root_url) }
  	    end
  	    
  	  end
  	  
  	  describe "as user" do
  	  	let(:user) { FactoryGirl.create(:user) }
  	  	
  	  	before { sign_in user, no_capybara: true }
  	  	
  	  	describe "submitting a GET request to the User#new action" do
  	  	  before { get new_user_path }
  	  	  specify { expect(response).to redirect_to(root_url) }
  	  	end 
  	  	
  	  	describe "submitting a POST request to the User#create action" do
  	  	  before  { post users_path }
  	  	  specify { expect(response).to redirect_to(root_url) }
  	  	end	  	
  	  	
  	  end
  	  
  	  describe "when attepmting to visit a protected page" do
  	    	  	
  	  	before do
  	  	  visit edit_user_path(user)
  	  	  fill_in "Email",    with: user.email
  	  	  fill_in "Password", with: user.password
  	  	  click_button "Sign in"
  	  	end
  	  	
  	  	describe "after signin in" do
  	  	  it { should have_title('Edit user') }
  	  	  
  	  	  describe "when sign in again" do
  	  	  	before do
  	  	  	  delete session_path(user)
  	  	  	  visit signin_path
  	  	  	  fill_in "Email",    with: user.email
  	  	  	  fill_in "Password", with: user.password
  	  	  	  click_button "Sign in"
  	  	  	end
  	  	  	
  	  	  	it { should have_title(user.name) }
  	  	  	
  	  	  end
  	  	end
  	  end
   	end
  end
end











