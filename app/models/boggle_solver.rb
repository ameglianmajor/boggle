class BoggleSolver
  def initialize input
    @length = input.length
    valid = input.inject( input.length == @length ) { |result, value| result && (value.length == @length) }
    if valid
      @board = input
    else
      raise ArgumentError.new("Valid data was not provided.")
    end
  end

  def find_all_valid_words
    binding.pry
    @word_list.select {|word| valid_word? word}
  end

  def valid_word? word
    atomic_elements = word_array word
    visit_chains = start_coordinates atomic_elements[0]
    i = 1
    while (next_atomic_element = atomic_elements[i])
      visit_chains.map! {|x| augment_visit_chain(x, next_atomic_element) }
      visit_chains.flatten!(1)
      i += 1
    end
    visit_chains.empty? ? false : true
  end

  def start_coordinates atomic_string
    valid_coordinates = []
    @length.times do |i|
      @length.times do |j|
        valid_coordinates << [[i,j]] if @board[i][j] == atomic_string
      end
    end
    valid_coordinates
  end

  def augment_visit_chain visit_chain, next_atomic_string
    possible_visits = valid_neighbors visit_chain
    matches = possible_visits.select { |x| @board[x[0]][x[1]] == next_atomic_string }
    return_chains = matches.collect do |x|
      visit_chain+[x]
    end
    return_chains
  end

  def valid_neighbors visit_chain
    valid_neighbors = neighbors visit_chain.last
    visit_chain.map { |x| valid_neighbors.delete(x) }
    valid_neighbors
  end

  def neighbors coordinates
    return_values = one_dim_neighbors(coordinates[0]).product(one_dim_neighbors(coordinates[1]))
    return_values.delete coordinates
    return_values
  end

  def one_dim_neighbors n
    return_values = [n-1, n, n+1]
    return_values.select {|n| 0 <= n && n < @length}
  end

  def word_array word
    length = word.length - 1
    atomic_elements = []
    length.times do |i|
      if word[i] == 'q'
        atomic_elements << 'qu'
      else
        if i == 0 || word[i-1] != 'q'
          atomic_elements << word[i]
        end
      end
    end
    atomic_elements
  end

  def load_words
    @word_list = []
    fh = File.open("#{Rails.root}/dictionary/#{WORD_LIST}")
    while (line = fh.gets)
      @word_list << line
    end
    fh.close
  end

end
