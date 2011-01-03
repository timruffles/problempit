require File.dirname(__FILE__) + '/../acceptance_helper'

feature "So that I can log a problem on the site
As a user
I want a problem entry screen
That allows me to add a problem and my opinion on it similutaneously
And lets me create a problem before logging in
Because it'll put me off using the site otherwise
" do
  [lambda { login_as("Billy")}, lambda { not_logged_in}].each do |before|
    before :each &before
    scenario {
      visit('problems/new')
      submit_validly_filled_new_form_for(Problem)
      should have_created_an_instance_with_message
    }
    scenario {
      visit('problems/new')
      submit_invalidly_filled_new_form_for(Problem)
      should_not have_created_an_instance_with_message
    }
  end
end