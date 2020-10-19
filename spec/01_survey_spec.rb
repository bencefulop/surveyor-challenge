require 'spec_helper'
require 'pry'

RSpec.describe Surveyor::Survey do
  subject { described_class.new(name: "Engagement Survey") }
  # let(response_1) { Response.new("john_doe@gmail.com") }
  # let(response_2) { Response.new("jane_doe@gmail.com") }

  it "has a name" do
    expect(subject.name).to eq("Engagement Survey")
  end

  it "can have questions added" do
    question = double(:question)
    subject.add_question(question)
    expect(subject.questions).to include(question)
  end

  it "can have responses added" do
    response = double(:response)
    subject.add_response(response)
    expect(subject.responses).to include(response)
  end

  context "Search for a response" do
    test_response = Surveyor::Response.new(email: "john_doe@gmail.com")
    it "returns response object if email is found" do
      subject.add_response(test_response)
      expect(subject.find_response_by_email("john_doe@gmail.com")).to eq([test_response])
    end

    it "returns nil if email isn't found" do
      subject.add_response(test_response)
      expect(subject.find_response_by_email("test1@gmail.com")).to eq(nil)
    end
  end

  context "User responded?" do
    test_response = Surveyor::Response.new(email: "john_doe@gmail.com")
    it "returns true if user has responded" do
      subject.add_response(test_response)
      expect(subject.user_responded?("john_doe@gmail.com")).to eq(true)
    end

    it "returns false if they haven't" do
      subject.add_response(test_response)
      expect(subject.user_responded?("test1@gmail.com")).to eq(false)
    end
  end
end
