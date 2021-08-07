class Enigma
  def initialize
  end

  def encrypt(message, key, date)
    Encryption.new({
      message: message,
      key: key,
      date: date
    })

  end

  def decrypt(decryption, key, date)
  end
end