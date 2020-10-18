require_relative 'response'

module Surveyor
  class Answer
    attr_accessor :question

    def initialize(question, *value)
      @question = question
      #method to raise error if @question is false or nil ⬆️
      @value = value
    end

  end
end