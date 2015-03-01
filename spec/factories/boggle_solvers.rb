FactoryGirl.define do
  factory :boggle_solver do
    ignore do
      sample_board [['e','y','k','d'], ['o','e','l','g'], ['r','u','p','h'], ['n','t','s','i']] 
    end
    word_list_filepath =  "#{Rails.root}/dictionary/#{Rails.application.config.word_list_filename}"
    initialize_with { BoggleSolver.new(sample_board, word_list_filepath ) }
  end
end
