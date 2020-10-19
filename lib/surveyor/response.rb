module Surveyor
  class Response
    attr_reader :email
    attr_accessor :answers

    def initialize(attributes = {})
      @email = attributes[:email]
      # Answers are added to responses instead of Surveys
      @answers = []
    end

    def valid_email?(email)
      email_regex = /\A[^@\s]+@[^@\s]+\z/
      email.class == String && email.match?(email_regex)
    end

    def add_answer(answer)
      @answers << answer
    end
  end
end
