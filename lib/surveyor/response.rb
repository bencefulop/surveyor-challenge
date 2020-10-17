module Surveyor
  class Response
    attr_reader :email
    
    def initialize(attributes = {})
      @email = attributes[:email]
    end
  end
end
