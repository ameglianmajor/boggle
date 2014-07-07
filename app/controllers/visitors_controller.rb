class VisitorsController < ApplicationController
  def index
    @length = 4
  end

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
