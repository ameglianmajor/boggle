class BoggleSolver
  def initialize input, word_list_filepath
    @length = input.length
    load_words word_list_filepath
    @board = input
    downcase_board
  end

  # For a fixed board size, this algorithm is typically O(N), where N is the number of
  # words in the dictionary. This assumes that the strings being searched for
  # are words in the English language. Since the longest word is 32 letters,
  # the word length can be treated as a constant from a computational
  # complexity perspective. Branching of visit_chains also needs to be considered
  # for worst case analysis, but branching is not a consideration in most cases.
  def find_all_valid_words
    @word_list.select {|word| valid_word? word}
  end

  def downcase_board
    @board.each {|column| column.map!(&:downcase) }
  end

  def valid_word? word
    atomic_elements = word_array word
    found_word_chains = atomic_elements[1..-1].
      inject(start_coordinates atomic_elements[0]) do |visit_chains, atomic_element|
        return false if visit_chains.empty?
        visit_chains.map! {|x| augmented_visit_chains(x, atomic_element) }
        visit_chains.flatten!(1)
      end
    found_word_chains.empty? ? false : true
  end

  def start_coordinates atomic_string
    (0..@length-1).collect do |i|
      (0..@length-1).collect do |j|
        [[i,j]] if @board[i][j] == atomic_string
      end.compact # compacting removes nils
    end.flatten(1) # flatten(1) removes the nesting caused by the double loop
  end

  def augmented_visit_chains visit_chain, next_atomic_string
    possible_visits = unvisited_neighbors visit_chain
    matching_visits = possible_visits.select { |x| @board[x[0]][x[1]] == next_atomic_string }
    matching_visits.map {|match| visit_chain+[match]}
  end

  def unvisited_neighbors visit_chain
    valid_neighbors = neighbors visit_chain.last
    valid_neighbors - visit_chain
  end

  def neighbors coordinates
    neighbors_and_self =
      one_dim_neighbors(coordinates[0]).product(one_dim_neighbors(coordinates[1]))
    neighbors_and_self - [coordinates]
  end

  def one_dim_neighbors n
    [n-1, n, n+1].select {|n| 0 <= n && n < @length}
  end

  def word_array word
    # (?<!q) is a look behind regexp operation
    word.scan(/(?<!q)u|qu|[a-pr-tv-z]/)
  end

  def load_words word_list_filepath
    file_handle = File.open("#{word_list_filepath}", 'r')
    @word_list = file_handle.collect { |file| file.strip.downcase }
    file_handle.close
  end
end
