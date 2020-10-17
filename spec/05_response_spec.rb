require 'spec_helper'

RSpec.describe Surveyor::Response do
  subject { described_class.new(email: "john_doe@gmail.com") }

  it "has an email address" do
    expect(subject.email).to eq("john_doe@gmail.com")
  end
end
