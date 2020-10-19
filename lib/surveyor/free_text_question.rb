require_relative 'question'

module Surveyor
  class FreeTextQuestion < Question
    def valid_answer?(answer)
      answer.class == String
    end
  end
end

# ft_question = Surveyor::FreeTextQuestion.new(title: "How happy are you?")
# p ft_question.class.superclass

