require_relative 'question'
require_relative 'free_text_question'
require_relative 'rating_question'
require_relative 'response'
require 'pry'

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

    def show_question_ratings_classes(question)
      ratings = get_question_ratings(question)
      neutral, low, high = [], [], []
      ratings.select do |rating|
        if rating >= 4
          high << rating
        elsif rating == 3
          neutral << rating
        else
          low << rating
        end
      end
      puts  "Low: #{low.size}"
      puts "Neutral: #{neutral.size}"
      puts "High: #{high.size}"
    end

    def show_question_ratings_breakdown(question)
      ratings = get_question_ratings(question)
      puts "1: #{ratings.count(1)}"
      puts "2: #{ratings.count(2)}"
      puts "3: #{ratings.count(3)}"
      puts "4: #{ratings.count(4)}"
      puts "5: #{ratings.count(5)}"
    end

    private
    
    def get_question_ratings(question)
      ratings = []
      #select all answers from suervey
      answers = @responses.map {|response| response.answers}
      # filter answers that correspond to question
      results = answers.map do |answer| 
        answer.select do |answer_element| 
          answer_element.question.title == question.title
        end
      end
      # get answer values
      results.map { |result| result.each { |result_element| ratings << result_element.value }}
      ratings
    end
  end
end

survey = Surveyor::Survey.new(name: "Engagement Survey")
response = Surveyor::Response.new(email: "john_doe@gmail.com")
survey.add_response(response)

response2 = Surveyor::Response.new(email: "jane_doe@gmail.com")
survey.add_response(response2)


question = Surveyor::RatingQuestion.new(title: "How happy are you?")
survey.add_question(question)

question2 = Surveyor::FreeTextQuestion.new(title: "Where do you live?")
survey.add_question(question2)

answer_1 = Surveyor::Answer.new(question, 5)
answer_2 = Surveyor::Answer.new(question, 4)
answer_3 = Surveyor::Answer.new(question, 3)
answer_4 = Surveyor::Answer.new(question2, "at home")
answer_5 = Surveyor::Answer.new(question, 2)
answer_6 = Surveyor::Answer.new(question, 4)
answer_7 = Surveyor::Answer.new(question, 2)
answer_8 = Surveyor::Answer.new(question2, "Canada")

response.add_answer(answer_1)
response.add_answer(answer_2)
response.add_answer(answer_3)
response.add_answer(answer_4)

response2.add_answer(answer_5)
response2.add_answer(answer_6)
response2.add_answer(answer_7)
response2.add_answer(answer_8)

# p question
# puts "-------------"

# binding.pry
survey.show_question_ratings_classes(question)
survey.show_question_ratings_breakdown(question)