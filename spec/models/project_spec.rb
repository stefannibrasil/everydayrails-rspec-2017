require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetest@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
  end

  it "does not allow duplicate project names per user" do
    @user.projects.create(
      name: "Test Project",
    )

    new_project = @user.projects.create(
      name: "Test Project",
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows two users to share a project name" do
    other_user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email:"joe2tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    @user.projects.create(
      name: "Test Project",
    )

    other_project = other_user.projects.build(
      name: "Test Project"
    )

    expect(other_project).to be_valid
  end

  describe 'project delivery date' do
    context 'when the due date has passed' do
      it 'returns #late? true' do
        project = @user.projects.create(
          name: "Test Project",
          due_on: Date.yesterday
        )

        expect(project.late?).to be true
      end
    end

    context 'when the due date has not passed' do
      it 'returns #late? false' do
        project = @user.projects.create(
          name: "Test Project",
          due_on: Date.tomorrow
        )

        expect(project.late?).to be false
      end
    end
  end
end
