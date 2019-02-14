require "./lib/chess.rb"

RSpec.describe Chess do

  before do
    @game = Chess.new("Alice", "Bob")
  end

  context "#initialize" do
    it "raises an error if not given input" do
      expect{ Chess.new }.to raise_error(ArgumentError)
    end

    it "raises an error if given only one name" do
      expect{ Chess.new("Alice") }.to raise_error(ArgumentError)
    end

    it "doesn't raise an error if given two names" do
      expect{ Chess.new("Alice", "Bob")}.to_not raise_error
    end
      
  end
end