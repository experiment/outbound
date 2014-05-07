# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    email 'ryan@experiment.com'
    name 'Ryan Lower'
    source 'filofax'
  end
end
