FactoryBot.define do
  factory :note, class: 'Note' do
    message "This is the first note."
    association :project
    user { project.owner }
  end
end
