require './lib/encryption'

class Enigma
  def initialize
  end

  def format_key
    string = ""
    until string.length == 5 do 
      string << "#{rand(0..9)}"
    end
    string
  end

  def format_date
    "#{Time.now.strftime("%m")}#{Time.now.strftime("%d")}#{Time.now.strftime("%y")}"
  end

  def encrypt(message, key = format_key, date = format_date)
    encrypting = Encryption.new({
      message: message,
      key: key,
      date: date, 
      status: "encryption" 
    })
    encrypting.format_message
  end

  def decrypt(message, key, date)
    encrypting = Encryption.new({
      message: message,
      key: key,
      date: date,
      status: "decryption" 
    })
    encrypting.format_message
  end
end