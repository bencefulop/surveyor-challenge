require_relative 'question'
require_relative 'response'

module Surveyor
  class Survey
    attr_reader :name
    attr_accessor :questions, :responses

    def initialize(attributes = {})
      @name = attributes[:name]
      @questions = []
      @responses = []
    end

    def add_question(question)
      @questions << question
    end

    def add_response(response)
      @responses << response
    end

    def find_response_by_email(email)
      result = @responses.select { |response| response.email == email }
      result.empty? ? nil : result
    end

    def user_responded?(email)
      find_response_by_email(email) != nil
    end
  end
end

survey = Surveyor::Survey.new(name: "Engagement Survey")
response = Surveyor::Response.new(email: "john_doe@gmail.com")

survey.add_response(response)
p survey.user_responded?("john_doe@gmail.com")
p survey.user_responded?("johndoe@gmail.com")
