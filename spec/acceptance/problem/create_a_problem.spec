feature "So that I can log a problem on the site
As a user
I want a problem entry screen
" do
  scenario "create a problem, but leave out fields"
  scenario "don't include a solution"
  context "logged in" do
    scenario "create a problem"
  end
  context "lazy logged in" do
    scenario "create a problem, should be prompted to login to create the problem"
  end
end