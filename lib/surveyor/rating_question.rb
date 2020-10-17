module Surveyor
  class RatingQuestion < Question
    def valid_answer?(answer)
      answer.class == Integer && (1..5).cover?(answer) ? true : false
    end
  end
end
