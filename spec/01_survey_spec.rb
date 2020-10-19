require 'spec_helper'
require 'pry'

RSpec.describe Surveyor::Survey do
  subject { described_class.new(name: "Engagement Survey") }

  let(:response_1) { Surveyor::Response.new(email: "john_doe@gmail.com") }
  let(:response_2) { Surveyor::Response.new(email: "jane_doe@gmail.com") }

  let(:question_1) { Surveyor::RatingQuestion.new(title: "How happy are you at work?") }
  let(:question_2) { Surveyor::FreeTextQuestion.new(title: "Where do you live?") }

  let(:answer_1) { Surveyor::Answer.new(question_1, 5) }
  let(:answer_2) { Surveyor::Answer.new(question_1, 4) }
  let(:answer_3) { Surveyor::Answer.new(question_1, 3) }
  let(:answer_4) { Surveyor::Answer.new(question_2, "Melbourne") }
  let(:answer_5) { Surveyor::Answer.new(question_1, 2) }
  let(:answer_6) { Surveyor::Answer.new(question_1, 4) }
  let(:answer_7) { Surveyor::Answer.new(question_1, 2) }
  let(:answer_8) { Surveyor::Answer.new(question_2, "Sydney") }

  before(:each) do
    subject.add_response(response_1)
    subject.add_response(response_2)
    subject.add_question(question_1)
    subject.add_question(question_2)

    response_1.add_answer(answer_1)
    response_1.add_answer(answer_2)
    response_1.add_answer(answer_3)
    response_1.add_answer(answer_4)

    response_2.add_answer(answer_5)
    response_2.add_answer(answer_6)
    response_2.add_answer(answer_7)
    response_2.add_answer(answer_8)
  end

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
    it "returns response object if email is found" do
      expect(subject.find_response_by_email("john_doe@gmail.com")).to eq([response_1])
    end

    it "returns nil if email isn't found" do
      expect(subject.find_response_by_email("test1@gmail.com")).to be_nil
    end
  end

  context "User responded?" do
    it "returns true if user has responded" do
      expect(subject.user_responded?("john_doe@gmail.com")).to eq(true)
    end

    it "returns false if they haven't" do
      expect(subject.user_responded?("test1@gmail.com")).to eq(false)
    end
  end

  context "Question analysis" do
    it "returns the number of low Answers" do
      expect(subject.count_low_rated_answers(question_1)).to eq(2)
    end

    it "returns the number of neutral Answers" do
      expect(subject.count_neutral_rated_answers(question_1)).to eq(1)
    end

    it "returns the number of high Answers" do
      expect(subject.count_high_rated_answers(question_1)).to eq(3)
    end

    it "returns breakdown of Answers" do
      str = "1: 0\n
             2: 2\n
             3: 1\n
             4: 2\n
             5: 1"
      expect(subject.show_question_ratings_breakdown(question_1)).to eq(str)
    end
  end
end
