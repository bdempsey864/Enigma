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
      expect(date_message.date).to eq('080521')
    end

    xit 'can encrypt a message given key and date' do
      expect(coded_message.encrypt).to eq("hello world")
    end
  end
end