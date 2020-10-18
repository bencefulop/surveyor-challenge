require_relative 'response'

module Surveyor
  class Answer
    attr_accessor :question

    def initialize(question, *value)
      @question = question
      @value = value
    end
  end
end
