require_relative 'response'

module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(question, *value)
      @question = valid_question?(question)
      @value = value
    end

    def valid_question?(question)
      question_error = StandardError.new "Must specify the question you're answering"
      question.class == Surveyor::Question ? question : question_error
    end
  end
end
