require './lib/special_char'

RSpec.describe SpecialChar do 
  context "initialize" do
    it 'exists' do
      expect(SpecialChar.new("")).to be_a SpecialChar
    end

    it 'finds special characters and their index pos' do 
      specials = SpecialChar.new("hello! world!")
      expect(specials.positions).to eq({
        "!" => [5,12] 
      })
    end

    it 'removes special characters' do 
      specials = SpecialChar.new("hello! world!")
      expect(specials.remove_chars).to eq("hello world")
    end
  end
end