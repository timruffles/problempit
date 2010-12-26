FactoryGirl.define do
  sequence :email do |n|
    "blah_#{n}@gsplatingemail.com"
  end
  factory :user do
    password 'Secret1'
    email Factory.next :email
  end
  factory :invalid_user, :parent => :user do
    email "not quit roit"
  end
end