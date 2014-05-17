# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :outbound_process do
    contact
    workflow_state 'pending'
  end
end
