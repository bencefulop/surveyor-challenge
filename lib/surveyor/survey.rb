module Surveyor
  class Survey
    attr_reader :name
    attr_accessor :questions, :responses

    def initialize(attributes = {})
      @name = attributes[:name]
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
      result = @responses.select { |response| response.email == email }
      result.empty? ? nil : result
    end

    def user_responded?(email)
      find_response_by_email(email) != nil
    end

    def count_low_rated_answers(question)
      ratings = get_question_ratings(question)
      ratings.select { |rating| rating < 3 }.size
    end

    def count_neutral_rated_answers(question)
      ratings = get_question_ratings(question)
      ratings.select { |rating| rating == 3 }.size
    end

    def count_high_rated_answers(question)
      ratings = get_question_ratings(question)
      ratings.select { |rating| rating >= 4 }.size
    end

    def show_question_ratings_breakdown(question)
      ratings = get_question_ratings(question)
      str = "1: #{ratings.count(1)}\n
             2: #{ratings.count(2)}\n
             3: #{ratings.count(3)}\n
             4: #{ratings.count(4)}\n
             5: #{ratings.count(5)}"
      str
    end

    private

    def get_question_ratings(question)
      ratings = []
      # select all answers from survey
      answers = @responses.map(&:answers)
      # filter answers that correspond to question
      results = answers.map do |answer|
        answer.select do |answer_element|
          answer_element.question.title == question.title
        end
      end
      # get answer values
      results.map { |result| result.each { |result_element| ratings << result_element.value } }
      ratings
    end
  end
end
