require_relative 'response'

module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(question, *value)
      @question = valid_question?(question)
      @value = value
      # @value = set_valu0e_class(value)
    end

    def valid_question?(question)
      question_error = StandardError.new "Must specify the question you're answering"
      question.class.superclass == Surveyor::Question ? question : question_error
    end

    private 

    # def set_value_class(value)
    #   if @question.class == Surveyor::RatingQuestion

    #   else
    #   end
    # end
  end
end
