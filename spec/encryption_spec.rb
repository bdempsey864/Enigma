require 'spec_helper'
require 'date'
require './lib/encryption'

RSpec.describe Encryption do 
  context 'initialize' do 
    coded_message = Encryption.new({
      message: 'hello world',
      key: '02715',
      date: '040895'
    })
    
    it 'exists' do 
      expect(coded_message).to be_instance_of Encryption
    end

    it '#format_date' do 
      date_message = Encryption.new({
        message: 'hello world',
        key: '02715'
      })
      expect(date_message.date).to eq("#{Time.now.strftime("%m")}#{Time.now.strftime("%d")}#{Time.now.strftime("%y")}")
    end

    it '#format_key' do 
      date_message = Encryption.new({
        message: 'hello world'
      })
    expect(date_message.key).to be_a String
    expect(date_message.key.length).to eq(5)
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
    end

    it '#offsets' do
      expect(coded_message.offsets).to eq([7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3])
    end

    it '#new_index' do 
      expect(coded_message.new_index).to eq([10, 31, 84, 31, 17, 53, 95, 34, 20, 38, 76])
    end

    it 'can encrypt a message given key and date' do
      expect(coded_message.encrypt).to eq("keder ohulw")
    end

    it 'can encrypt a message using todays date' do 
      todays_date = Encryption.new({
      message: 'hello world',
      key: '02715',
      date: "#{Time.now.strftime("%m")}#{Time.now.strftime("%d")}#{Time.now.strftime("%y")}"
      })

      expect(todays_date.encrypt).to be_a String
    end

    it '#decrypted_index' do 
      expect(coded_message.decrypted_index).to eq
    end

    it 'can decrypt a message given key and date' do 
      decrypt_message = Encryption.new({
      message: 'keder ohulw',
      key: '02715',
      date: '040895'
      })

      expect(decrypt_message.decrypt).to eq('hello world')
    end
  end
end