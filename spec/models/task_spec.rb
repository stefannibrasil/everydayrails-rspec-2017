require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetesting@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    @project = @user.projects.create(
      name: "Test Project",
    )

    @task = Task.new(
      project: @project,
      name: 'Finish Model exercises'
    )
  end

  it 'is valid with a project and a name' do
    expect(@task.valid?).to be true
  end

  it 'is not valid without a name' do
    new_task = Task.new(project: @project, name: nil)

    new_task.valid?
    expect(new_task.errors[:name]).to include("can't be blank")
  end

  it 'is not valid without a project' do
    new_task = Task.new(project: nil, name: 'Clean up cat litter')

    new_task.valid?
    expect(new_task.errors[:project]).to include("can't be blank")
  end
end
