require 'spec_helper'
require 'date'
require './lib/enigma'

RSpec.describe Enigma do
  context "#initialize" do 
    enigma = Enigma.new

    it 'exists' do 
      expect(enigma).to be_instance_of Enigma
    end

    it '#encrypt(encryption, key, date)' do 
      expect(enigma.encrypt("hello world", "02715", "040895")).to eq({
        message: "keder ohulw",
        key: "02715",
        date: "040895"
      })
    end

    xit '#decrypt(decryption, key, date)' do
      expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq({
        decryption: "hello world",
        key: "02715",
        date: "040895"
      })
    end

    xit 'encrypts without a key' do
      expect(enigma.encrypt.keys("hello world", "040895")).to eq([:encryption, :key, :date])
    end
  end
end