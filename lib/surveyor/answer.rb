module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(question, *value)
      @question = valid_question?(question)
      @value = assign_class_of_value(value)
    end

    def valid_question?(question)
      # method to throw an error if argument isn't a Question class
      question_error = StandardError.new "Must specify the question you're answering"
      question.class.superclass == Surveyor::Question ? question : question_error
    end

    private

    def assign_class_of_value(value)
      # value is stored either as a string or integer depending on the Question's class
      @question.class == Surveyor::RatingQuestion ? value[0].to_i : value[0].to_s
    end
  end
end
