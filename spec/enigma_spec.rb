require 'spec_helper'
require 'date'
require './lib/enigma'

RSpec.describe Enigma do
  context "#initialize" do 
    enigma = Enigma.new

    it 'exists' do 
      expect(enigma).to be_instance_of Enigma
    end

    it '#format_key' do 
      date_message = enigma.format_key
      expect(date_message).to be_a String
      expect(date_message.length).to eq(5)
    end

    it '#format_date' do 
      date_message = enigma.format_date
      expect(date_message).to eq("#{Time.now.strftime("%m")}#{Time.now.strftime("%d")}#{Time.now.strftime("%y")}")
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
      expect(info.keys).to eq([:key, :date, :encryption])
      expect(info).to be_a Hash
    end

    it 'encrypt without a date or key' do
      info = enigma.encrypt("hello world")
      expect(info.keys).to eq([:key, :date, :encryption])
      expect(info).to be_a Hash
    end
  end
end