FactoryBot.define do
  factory :project, class: 'Project' do
    sequence(:name) { |n| "Project #{n}" }
    description "A test project."
    due_on 1.week.from_now
    owner { User.find_or_create_by(first_name: 'Stefanni') }

    trait :with_notes do
      after(:create) { |project| create_list(:note, 5, project: project) }
    end

    trait :due_yesterday do
      due_on 1.day.ago
    end

    trait :due_today do
      due_on Date.current.in_time_zone
    end

    trait :due_tomorrow do
      due_on 1.day.from_now
    end
  end

  factory :business_project, class: 'Project' do
    sequence(:name) { |n| "Project #{n}" }
    description "Starting my first business."
    due_on 2.weeks.from_now
    owner { User.find_or_create_by(first_name: 'Stefanni') }
  end
end
