require 'spec_helper'
include RestaurantHelper

feature "Add a Restaurant" do
	context "On Purpose" do
		before(:each) do
			visit '/restaurants/new'
		end
		
		it "should route to the correct page" do
			page.should have_content 'New'
		end

		it "should add a new restaurant and get to the page" do
			expect {
				fill_in "restaurant_name", with: "Pizza Hut"
				fill_in "restaurant_address", with: "123 F"
				fill_in "restaurant_city", with: "Chicag"
				fill_in "restaurant_state", with: "IL"
				fill_in "restaurant_zip", with: "60622"
				fill_in "restaurant_cuisine", with: "Pizza"
				click_button 'Create Restaurant'
			}.to change(Restaurant, :count).by(1)
		end

		it "should not accept a form with missing fields" do
			expect {
				fill_in "restaurant_address", with: "123 F"
				fill_in "restaurant_city", with: "Chicag"
				fill_in "restaurant_state", with: "IL"
				fill_in "restaurant_zip", with: "60622"
				fill_in "restaurant_cuisine", with: "Pizza"
				click_button 'Create Restaurant'
			}.to raise_error()
		end
	end

end