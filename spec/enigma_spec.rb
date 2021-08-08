require 'spec_helper'
require 'date'
require './lib/enigma'

RSpec.describe Enigma do
  context "#initialize" do 
    enigma = Enigma.new

    it 'exists' do 
      expect(enigma).to be_instance_of Enigma
    end

    it '#encrypt(message, key, date)' do 
      expect(enigma.encrypt("hello world", "02715", "040895")).to eq({
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      })
    end

    it '#decrypt(decryption, key, date)' do
      expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq({
        decryption: "hello world",
        key: "02715",
        date: "040895"
      })
    end

    it 'encrypts without a key' do
      info = enigma.encrypt("hello world", "040895")
      expect(info.keys).to eq([:encryption, :key, :date])
      require "pry"; binding.pry
    end
  end
end