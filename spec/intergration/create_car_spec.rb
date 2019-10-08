require 'rails_helper'
require 'spec_helper'
describe 'Process of creation car after logi in in system', type: :feature do
  before(:all) { @user = create(:user) }

    it 'successfully create' do
      goto 'http://localhost:3000/users/sign_in'
      
      text_field(id: 'user_email').set @user.email
      text_field(id: 'user_password' ).set '1234567'
      button(type: 'submit').click
      goto "http://localhost:3000/profiles/#{@user.profile.id}"
      link(text: 'Create new car').click
      select_list(id: 'make').select 'Volkswagen'
      select_list(id: 'model').select 'Phaeton'
      select_list(id: 'year').select '2004'
      select_list(id: 'car_vehicle_type').select 'sedan'
      select_list(id: 'car_fuel_type').select 'diesel'
      text_field(id: 'car_cubic_capacity').set 3600
      select_list(id: 'car_transmission').select 'manual'
      text_field(id: 'purchase').set 2006
      text_field(id: 'car_mileage').set 40000
      textarea(id: 'car_description').set 'Vehicle refers to anything used as means of transportation. Automobiles'
      button(type: 'submit').click
      expect(link(text: "Delete car")).to be_present
      sleep 2

      linK =  link(text: 'Delete car')
      linK.exist?
      linK.click
    end
end
