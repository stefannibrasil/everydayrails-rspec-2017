require 'rails_helper'

RSpec.describe Note, type: :model do
  it "returns notes that match the search term" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    project = user.projects.create(
      name: "Test Project",
    )

    note1 = project.notes.create(
      message: 'Cats are cute',
      user: user
    )

    note2 = project.notes.create(
      message: 'Cats are difficult to understand',
      user: user
    )

    note3 = project.notes.create(
      message: 'Dogs are funny',
      user: user
    )

    expect(Note.search('cats')).to include(note1, note2)
    expect(Note.search('cats')).not_to include(note3)
  end

  it "returns an empty collection when no results are found" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    project = user.projects.create(
      name: "Test Project",
    )

    note1 = project.notes.create(
      message: 'Cats are cute',
      user: user
    )

    note2 = project.notes.create(
      message: 'Cats are difficult to understand',
      user: user
    )

    note3 = project.notes.create(
      message: 'Dogs are funny',
      user: user
    )

    expect(Note.search("lizards")).to be_empty
  end
end
