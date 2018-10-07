FactoryBot.define do
  sequence :email do |n|
    "vaibhav#{n}@chaturbots.com"
  end
end

FactoryBot.define do

  factory :user do
    login         'vaibhav@chaturbots.com'
    firstname     'Vaibhav'
    lastname      'Maheshwari'
    email         { generate(:email) }
    password      nil
    active        true
    login_failed  0
    updated_by_id 1
    created_by_id 1
  end

  factory :customer_user, parent: :user do
    role_ids { Role.signup_role_ids.sort }
  end

  factory :agent_user, parent: :user do
    roles { Role.where(name: 'Agent') }
  end

  factory :admin_user, parent: :user do
    roles { Role.where(name: %w[Admin Agent]) }
  end
end
