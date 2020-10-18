require_relative 'response'

module Surveyor
  class Answer
    attr_accessor :question, :value

    def initialize(question, *value)
      @question = valid_question?(question)
      @value = value
    end

    def valid_question?(question)
      question_error = StandardError.new "Must specify the question you're answering"
      question.class == String && question[-1] == "?" ? question : question_error
    end
  end
end
