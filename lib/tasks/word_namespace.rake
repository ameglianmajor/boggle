namespace :word_namespace do
  desc "Merge the words in two or more separate word lists. The input files should be word lists with 1 word per line. The output list has the same format."
  task merge_word_lists: :environment do
    input_files = []
    i = 1
    while(input_file_name = ENV["input_file_#{i}"])
      if input_file_name
        input_files << input_file_name
        i += 1
      end
    end
    word_lists = input_files.map { |file| create_word_array file }
    complete_list = word_lists.inject ([]) {|result, element| result.concat(element) }
    write_array ENV["output_file"], complete_list
  end

  desc "Eliminate words that contain a q not followed by a u."
  task eliminate_illegal_words: :environment do
    word_list = create_word_array ENV["input_file"]
    word_list.select! {|x| legal_word(x) }
    write_array ENV["output_file"], word_list
  end

  desc "Eliminate words that are too short. Qu is treated as one character for the purpose of character count."
  task eliminate_short_words: :environment do
    word_list = create_word_array ENV["input_file"]
    word_list.select! {|x| boggle_length(x) > 3 }
    write_array ENV["output_file"], word_list
  end

  desc "Eliminate words that are too long. Qu is treated as one character for the purpose of character count."
  task eliminate_long_words: :environment do
    word_list = create_word_array ENV["input_file"]
    word_list.select! {|x| boggle_length(x) < 17 }
    write_array ENV["output_file"], word_list
  end

end

def create_word_array file_name
  word_list = []
  if file_name
    fh = File.new("./dictionary/#{file_name}", "r")
    while (line = fh.gets)
      word_list << line
    end
    fh.close
    word_list.map { |x| convert_to_linux_line_ending! x }
  end
  word_list
end

def convert_to_linux_line_ending! line
  if line[-2] == "\r"
    line[-2] = ''
  end
end

def write_array output_file, word_list
  if output_file
    fh = File.open("./dictionary/#{output_file}", "w")
    word_list.each { |word| fh.write(word) }
    fh.close
  end
end

def legal_word word
  (word.include? 'q') ? (word.include? 'qu') : true
end

def boggle_length word
  if word.include? 'q'
    word.length - word.count('q')
  else
    word.length
  end
end