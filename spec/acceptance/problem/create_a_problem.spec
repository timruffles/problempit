feature "So that I can log a problem on the site
As a user
I want a problem entry screen
" do
  it {
    visit('problem/new')
    submit_validly_filled_new_form_for(Problem)
    should have_created_an_instance_with_message
  }
  it {
    visit('problem/new')
    submit_invalidly_filled_new_form_for(Problem)
    should_not have_created_an_instance_with_message
  }
end