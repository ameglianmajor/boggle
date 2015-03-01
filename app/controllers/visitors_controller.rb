class VisitorsController < ApplicationController
  @board_size = Rails.application.config.board_size

  api :GET, 'visitors/index', 'Get a form to enter a Boggle board.'
  description <<-EOS
  This endpoint displays a grid in which a Boogle board can be entered.
  EOS
  def index
    length
  end

  api :POST, 'visitors/determine_words', 'Post a 2d array of letters and obtain a list of valid words.'
  description <<-EOS
  This endpoint is used to obtain a list of valid words found in the 2d array of letters that are sent.
  EOS
  @board_size.times do |i|
    @board_size.times do |j|
      param "(#{i},#{j})".to_sym, /^([A-PR-Za-pr-z]|(Q|q)(U|u))$/, desc: "Single letter unless it is the pair qu.", required: true
    end
  end
  error 400, 'Bad Request. Please check that all parameters were provided and that the request is syntactically correct.'
  def determine_words
    # The view expects @length to be set.
    # Thus, the memoized function length must be called at least once in this method.
    @matrix = self.class.two_dim_table length
    length.times do |i|
      length.times do |j|
        @matrix[i][j] = params["(#{i},#{j})"]
      end
    end
    bs = BoggleSolver.new @matrix, "#{Rails.root}/dictionary/#{Rails.application.config.word_list_filename}"
    @valid_words = bs.find_all_valid_words
  end

    private

    def length
      @length ||= Rails.application.config.board_size
    end

    def self.two_dim_table size
      Array.new(size).inject([]) { |initial, increment| initial.push(Array.new(size)) }
    end

end
