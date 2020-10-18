require 'spec_helper'

RSpec.describe Surveyor::Answer do
  subject { described_class.new(question: "What is the capital of Australia?", value: "Canberra") }

  describe "initialize" do
    it "creating an Answer without specifying the question raises an error" do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
  end

  describe "question attribute" do
    it "should be able to read an answer's question" do
      expect(subject).to respond_to :question
    end
  end
end
