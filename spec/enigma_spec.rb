require 'spec_helper'
require 'date'
require './lib/enigma'

RSpec.describe Enigma do
  context "#initialize" do 
    it 'exists' do 
      enigma = Enigma.new

      expect(enigma).to be_instance_of Enigma
    end

    it '#encrypt(encryption, key, date)' do 
      enigma = Enigma.new

      expect(enigma.encrypt("hello world", "02715", "040895")).to eq({
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      })
    end

    it '#decrypt(decryption, key, date)' do 
      enigma = Enigma.new

      expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq({
        decryption: "hello world",
        key: "02715",
        date: "040895"
      })
    end

    it 'encrypts without a key' do 
      enigma = Enigma.new

      expect(enigma.encrypt.keys("hello world", "040895")).to eq([:encryption, :key, :date])
    end
  end
end