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
      assert(test_boggle_solver.valid_word? 'super')
      assert(test_boggle_solver.valid_word? 'turn')
      assert(test_boggle_solver.valid_word? 'leo')
      assert(test_boggle_solver.valid_word? 'pure')
      assert(test_boggle_solver.valid_word? 'kelp')
      assert(test_boggle_solver.valid_word? 'nuts')
      assert(!(test_boggle_solver.valid_word? 'torn'))
      assert(!(test_boggle_solver.valid_word? 'pest'))
    end
  end
  describe "method start_coordinates" do
    it "finds all starting coordinates." do
      test_boggle_solver = FactoryGirl.build(:boggle_solver)
      assert(test_boggle_solver.start_coordinates 'e' == [[0,0],[1,1]])
      assert(test_boggle_solver.start_coordinates 'u' == [[2,1]])
      assert(test_boggle_solver.start_coordinates 'qu' == [])
    end
  end
end
