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
  end
end
