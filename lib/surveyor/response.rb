module Surveyor
  class Response
    attr_reader :email

    def initialize(attributes = {})
      @email = attributes[:email]
    end

    def valid_email?(email)
      email_regex = /\A[^@\s]+@[^@\s]+\z/
      email.class == String && email.match?(email_regex)
    end
  end
end
