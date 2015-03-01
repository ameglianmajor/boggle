require 'rails_helper'

RSpec.describe BoggleSolver, :type => :model do

  describe "has" do
    it "a valid factory." do
      assert(FactoryGirl.build(:boggle_solver).is_a? BoggleSolver)
    end
  end

  describe "method find_all_valid_words" do
    it "has 156 words." do
      test_boggle_solver = FactoryGirl.build(:boggle_solver)
      expect(test_boggle_solver.find_all_valid_words.length).to eq(156)
    end
  end

  describe "method valid_word?" do
    it "only finds valid words." do
      test_boggle_solver = FactoryGirl.build(:boggle_solver)
      valid_words = ['super', 'turn', 'leo', 'pure', 'kelp', 'nuts']
      # While the word 'torn' and 'pest' are valid words, they are
      # not in the dictionary.
      invalid_words = ['torn', 'pest', 'qtzel', 'zelqzu']
      valid_words.each do |word|
        assert(test_boggle_solver.instance_eval {valid_word? word})
      end
      invalid_words.each do |word|
        assert(!(test_boggle_solver.instance_eval {valid_word? word}))
      end
    end
  end

  describe "method start_coordinates" do
    it "finds all starting coordinates." do
      test_boggle_solver = FactoryGirl.build(:boggle_solver)
      test_hash = {
        'e' => [[0,0],[1,1]],
        'u' => [[2,1]],
        'qu' => [],
      }
      test_hash.each do |key, value|
        assert(test_boggle_solver.instance_eval {
          start_coordinates key == value
        })
      end
    end
  end
end
