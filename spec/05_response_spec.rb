require 'spec_helper'

RSpec.describe Surveyor::Response do
  subject { described_class.new(email: "john_doe@gmail.com") }

  it "has an email address" do
    expect(subject.email).to eq("john_doe@gmail.com")
  end

  it "should be able to read a response's answers" do
    expect(subject).to respond_to :answers
  end

  context 'valid_email?' do
    it 'is valid when email address is in correct format' do
      expect(subject.valid_email?('john_doe@gmail.com')).to eq(true)
    end

    it 'is invalid when email is incorrect' do
      expect(subject.valid_email?('john_doe.gmail.com')).to eq(false)
    end

    it 'is invalid when email is not String' do
      expect(subject.valid_email?(1)).to eq(false)
    end
  end
end
