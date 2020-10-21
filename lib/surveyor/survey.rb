module Surveyor
  class Survey
    attr_reader :name, :questions, :responses

    def initialize(name:)
      @name = name
      @questions = []
      @responses = []
    end

    def add_question(question)
      @questions << question
    end

    def add_response(response)
      @responses << response
    end

    def find_response_by_email(email)
      @responses.find { |response| response.email == email }
    end

    def user_responded?(email)
      find_response_by_email(email) != nil
    end

    def count_low_rated_answers(question)
      get_question_ratings(question)
        .count { |rating| rating < 3 }
      # the above is a shorter way of doing the same thing
      # ratings = get_question_ratings(question)
      # ratings.select { |rating| rating < 3 }.size
    end

    def count_neutral_rated_answers(question)
      get_question_ratings(question)
        .count(3)
    end

    def count_high_rated_answers(question)
      get_question_ratings(question)
        .count { |rating| rating >= 4 }
    end

    def show_question_ratings_breakdown(question)
      ratings = get_question_ratings(question)
      breakdown = []
      breakdown << "1: #{ratings.count(1)}"
      breakdown << "2: #{ratings.count(2)}"
      breakdown << "3: #{ratings.count(3)}"
      breakdown << "4: #{ratings.count(4)}"
      breakdown << "5: #{ratings.count(5)}"
      breakdown.join("\n")
    end

    private

    def get_question_ratings(question)
      @responses
      .flat_map(&:answers)
      .select { |answer| answer.question == question }
      .map(&:value)
      # the above is the result of code review, the below is my old solution  my old solution.

      # ratings = []
      # # select all answers from survey
      # answers = @responses.map(&:answers)
      # # get answers that correspond to question
      # results = answers.map do |answer|
      #   answer.select do |answer_element|
      #     answer_element.question.title == question.title
      #   end
      # end
      # # push answer values to rating array and then return it
      # results.map { |result| result.each { |result_element| ratings << result_element.value } }
      # ratings
    end
  end
end
