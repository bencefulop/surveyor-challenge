module Surveyor
  class Survey
    attr_reader :name
    attr_accessor :questions

    def initialize(attributes = {})
      @name = attributes[:name]
      @questions = []
    end

    def add_question(question)
      @questions << question
    end
  end
end
