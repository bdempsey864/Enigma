class Encryption
  attr_reader :message, 
              :key, 
              :date,
              :alphabet
  def initialize(data)
    @message = data[:message].downcase
    @key = data.fetch(:key, format_key)
    @date = data.fetch(:date, format_date)
    @alphabet = ("a".."z").to_a << " "
    @status = data[:status]
  end

  def format_date
    "#{Time.now.strftime("%m")}#{Time.now.strftime("%d")}#{Time.now.strftime("%y")}"
  end

  def format_key
    string = ""
    until string.length == 5 do 
      string << "#{rand(0..9)}"
    end
    string
  end

  def key_hash
    key_hash = {}
    key_hash[:a_key] = key.split("")[0..1].join
    key_hash[:b_key] = key.split("")[1..2].join
    key_hash[:c_key] = key.split("")[2..3].join
    key_hash[:d_key] = key.split("")[3..4].join
    key_hash
  end

  def date_hash
    date_hash = {}
    offs = date.to_i**2
    date_hash[:a_offset] = offs.to_s[-4]
    date_hash[:b_offset] = offs.to_s[-3]
    date_hash[:c_offset] = offs.to_s[-2]
    date_hash[:d_offset] = offs.to_s[-1]
    date_hash
  end

  def shift
    shift = []
    key_hash.each do |key, value|
      date_hash.each do |k, v|
        if key.to_s[0] == k.to_s[0]
          shift << value.to_i + v.to_i
        end
      end
    end
    shift
  end

  def offsets
    offsets = []
    @message.split("").each do |letter|
      offsets << @alphabet.index(letter)
    end
    offsets
  end

  def new_index
    fours = offsets.each_slice(4).to_a
    new_index = []
    fours.each do |four|
      four.each_with_index do |ele, index|
        new_index << ele + shift[index]
      end
    end
    new_index
  end

  def encrypt
    encrypted_message = ""
    new_index.each do |index| 
      encrypted_message << @alphabet[index%27]
    end
    encrypted_message
  end

  def format_message
    final_message = {
      key: self.key,
      date: self.date
    }
    if @status == "encrypt" 
      final_message[:encryption] = self.encrypt
    else 
      final_message[:decryption] = self.decrypt
    end
    final_message
  end

  def decrypted_index
    fours = offsets.each_slice(4).to_a
    decrypted_index = []
    fours.each do |four|
      four.each_with_index do |ele, index|
        decrypted_index << ele - shift[index]
      end
    end
    decrypted_index
  end

  def decrypt
    decrypted_message = ""
    decrypted_index.each do |index| 
      decrypted_message << @alphabet[index%27]
    end
    decrypted_message
  end
end