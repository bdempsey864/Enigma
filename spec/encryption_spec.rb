require 'spec_helper'
require 'date'
require './lib/encryption'

RSpec.describe Encryption do 
  context 'initialize' do 
    coded_message = Encryption.new({
      message: 'Lloyd Christmas',
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

    it 'can encrypt a message given key and date' do
      expect(coded_message.encrypt).to eq("keder ohulw")
    end
  end
end