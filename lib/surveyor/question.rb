module Surveyor
  class Question
    attr_accessor :title

    def initialize(attributes = {})
      @title = attributes[:title]
    end
  end
end
