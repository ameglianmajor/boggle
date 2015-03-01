class VisitorsController < ApplicationController
  api :GET, 'visitors/index', 'Get a form to enter a Boggle board.'
  description <<-EOS
  This endpoint displays a grid in which a Boogle board can be entered.
  EOS
  def index
    @length = 4
  end

  api :POST, 'visitors/determine_words', 'Post a 2d array of letters and obtain a list of valid words.'
  description <<-EOS
  This endpoint is used to obtain a list of valid words found in the 2d array of letters that are sent.
  EOS
  4.times do |i|
    4.times do |j|
      param "(#{i},#{j})".to_sym, /^([A-PR-Za-pr-z]|[Qq][Uu])$/, desc: "Single letter unless it is the pair qu."
    end
  end
  error 400, 'Bad Request. Please check that all parameters were provided and that the request is syntactically correct.', required: true
  def determine_words
    @length = 4
    @matrix = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    @length.times do |i|
      @length.times do |j|
        @matrix[i][j] = params["(#{i},#{j})"]
      end
    end
    bs = BoggleSolver.new(@matrix)
    @valid_words = bs.find_all_valid_words
  end

end
