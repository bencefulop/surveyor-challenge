module Surveyor
  class Question
    attr_accessor :title

    def initialize(title:)
      @title = title
    end
  end
end
