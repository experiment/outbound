# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    sequence(:email) {|n| "#{n}@experiment.com" }
    name 'Ryan Lower'
    source 'filofax'
    info journal: 'Journal of Life'
  end
end
