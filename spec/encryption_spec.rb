require 'spec_helper'
require 'date'
require './lib/encryption'

RSpec.describe Encryption do 
  context 'initialize' do 
    coded_message = Encryption.new({
      message: 'hello world',
      key: '02715',
      date: '040895',
      status: 'encryption'
    })
    
    it 'exists' do 
      expect(coded_message).to be_an Encryption
    end

    it '#key_hash' do 
      expect(coded_message.key_hash).to eq({
        :a_key=>"02", 
        :b_key=>"27", 
        :c_key=>"71", 
        :d_key=>"15"
      })
    end

    it '#date_hash' do 
      expect(coded_message.date_hash).to eq({
        :a_offset=>"1", 
        :b_offset=>"0", 
        :c_offset=>"2", 
        :d_offset=>"5"
      })
    end

    it '#shift' do
      expect(coded_message.shift).to eq([3, 27, 73, 20])
      expect(coded_message.shift).to be_an Array
      expect(coded_message.shift.length).to eq 4
    end

    it '#character_index' do
      expect(coded_message.character_index).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
    end

    it '#new_index' do 
      expect(coded_message.current_index).to eq([10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76])
    end

    it 'can encrypt a message given key and date' do
      expect(coded_message.numbers_to_letters).to be_a String 
      expect(coded_message.numbers_to_letters).to eq("keder ohulw")
    end

    it 'can encrypt a message using todays date' do 
      todays_date = Encryption.new({
        message: 'hello world',
        key: '02715',
        date: "#{Time.now.strftime("%m")}#{Time.now.strftime("%d")}#{Time.now.strftime("%y")}"
        })

      expect(todays_date.numbers_to_letters).to be_a String
    end
  end

  context '#decrypt' do
    decrypt_message = Encryption.new({
      message: 'keder ohulw',
      key: '02715',
      date: '040895'
      })
      
    it '#decrypted_index' do 
      expect(decrypt_message.current_index).to eq([7, -23, -70, -16, 14, -1, -59, -13, 17, -16, -51])
    end

    it 'can decrypt a message given key and date' do 
      expect(decrypt_message.numbers_to_letters).to be_a String
      expect(decrypt_message.numbers_to_letters).to eq('hello world')
    end

    it 'ignores special characters' do 
      excited_message = Encryption.new({
        message: 'hello! world!',
        key: '02715',
        date: '040895',
        status: 'encryption'
        })
      excited_decrypted_message = Encryption.new({
        message: 'keder!sprrdx!',
        key: '02715',
        date: '040895',
        status: 'decryption'
        })
      expect(excited_message.character_index).to eq([7, 4, 11, 11, 14, "!", 26, 22, 14, 17, 11, 3, "!"])
      expect(excited_message.current_index).to eq([10, 31, 84, 31, 17, "!", 99, 42, 17, 44, 84, 23, "!"])
      expect(excited_message.numbers_to_letters).to eq("keder!sprrdx!")
      expect(excited_decrypted_message.current_index).to eq([7, -23, -70, -16, 14, "!", -55, -5, 14, -10, -70, 3, "!"])
      expect(excited_decrypted_message.numbers_to_letters).to eq("hello! world!")
    end
  end
end