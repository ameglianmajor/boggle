FactoryGirl.define do
  factory :boggle_solver do
    ignore do
      sample_board [['e','y','k','d'], ['o','e','l','g'], ['r','u','p','h'], ['n','t','s','i']] 
    end

    initialize_with { BoggleSolver.new(sample_board) }

  end
end
