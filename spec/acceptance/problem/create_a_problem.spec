require File.dirname(__FILE__) + '/../acceptance_helper'

feature "So that I can log a problem on the site
As a user
I want a problem entry screen
" do
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