require "./lib/chess/player"

RSpec.describe Player do

  context "#initialize" do
    it "requires input" do
      expect { Player.new }.to raise_error(ArgumentError)
    end

    it "requires two parameters" do
      expect{ Player.new("Bob")}.to raise_error(ArgumentError)
    end

    it "initializes with valid input" do
      expect{ Player.new("Bob", "white")}.to_not raise_error
    end
  end

  before do
    @player = Player.new("Laura", "white")
  end

  context "#name" do
    it "returns the name" do
      expect(@player.name).to eql "Laura"
    end

    it "can't change the name" do
      expect { @player.name = "Bob" }.to raise_error(NoMethodError)
    end
  end

  context "#color" do
    it "returns the color" do
      expect(@player.color).to eql "white"
    end

    it "can't change the color" do
      expect { @player.color = "black" }.to raise_error(NoMethodError)
    end
  end

end