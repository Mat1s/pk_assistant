require 'rails_helper'

describe 'Create car process', type: :feature do
  let!(:user) { create(:user) }

  describe 'login' do
    it 'allows a user to login' do
      @browser.goto "localhost:3000/users/sign_in"
      binding.pry
      @browser.text_field(id: 'user_email').set user.email
      @browser.text_field(id: 'user_password' ).set user.password
      @browser.button(value: 'Sign in').click
      
      expect(page).to have_content 'Welcome to the IDENTIFYY Platform!'
    end
  end
end
