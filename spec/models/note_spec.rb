require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @user = User.create!(
      first_name: "Joe",
      last_name: "Tester",
      email: "joeuser@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
    )

    @project = @user.projects.create(
      name: "Test Project"
    )
  end

  it "is valid with a user, project and message" do
    note = Note.new(
      user: @user,
      project: @project,
      message: 'Hello, cats'
    )

    expect(note).to be_valid
  end

  it "is invalid without a message" do
    note = Note.new(message: nil)
    note.valid?

    expect(note.errors[:message]).to include("can't be blank")
  end

  describe "search message for a term" do
    before do
      # try to use better names, for example, @matching_node
      # or @note_with_numbers_only, etc.
      # It depends on what you’re testing, but as a general rule,
      # try to be expressive with your variable and method names!
      @note1 = @project.notes.create(
        message: 'Cats are cute',
        user: @user
      )

      @note2 = @project.notes.create(
        message: 'Cats are difficult to understand',
        user: @user
      )

      @note3 = @project.notes.create(
        message: 'Dogs are funny',
        user: @user
      )
    end

    context "when a match is found" do
      it "returns notes that match the search term" do
        expect(Note.search('cats')).to include(@note1, @note2)
      end
    end

    context "when no match is found" do
      it "returns an empty collection when no results are found" do
        expect(Note.search("I am looking for lizards")).to be_empty
      end
    end
  end
end
