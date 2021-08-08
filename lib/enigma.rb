require './lib/encryption'

class Enigma
  def initialize
  end

  def encrypt(message, key, date)
    encrypting = Encryption.new({
      message: message,
      key: key,
      date: date, 
      status: "encrypt" 
    })
    encrypting.format_message
  end

  def decrypt(message, key, date)
    encrypting = Encryption.new({
      message: message,
      key: key,
      date: date,
      status: "decrypt" 
    })
    encrypting.format_message
  end
end