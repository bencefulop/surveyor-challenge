module Surveyor
  class Answer
    attr_accessor :question
    validates :question, presence: true

    def initialize(attributes = {})
      @question = attributes[:question]
    end
  end
end