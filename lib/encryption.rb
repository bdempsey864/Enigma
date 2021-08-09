class Encryption
  attr_reader :message, 
              :key, 
              :date,
              :alphabet
  def initialize(data)
    @message = data[:message].downcase
    @key = data.fetch(:key)
    @date = data.fetch(:date)
    @alphabet = ("a".."z").to_a << " "
    @status = data[:status]
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
    offset = (date.to_i**2).to_s
    date_hash[:a_offset] = offset[-4]
    date_hash[:b_offset] = offset[-3]
    date_hash[:c_offset] = offset[-2]
    date_hash[:d_offset] = offset[-1]
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

  def character_index
    character_index = []
    @message.split("").each do |letter|
      if !@alphabet.include?(letter)
        character_index << letter
      else 
        character_index << @alphabet.index(letter)
      end
    end
    character_index
  end

  def new_index
    message_grouped_by_four = character_index.each_slice(4).to_a
    new_index = []
    message_grouped_by_four.each do |four|
      four.each_with_index do |element, index|
        if !element.is_a? Integer
          new_index << element 
        else
          new_index << element + shift[index]
        end
      end
    end
    new_index
  end

  def format_message
    final_message = {
      key: self.key,
      date: self.date
    }
    final_message[@status.to_sym] = self.numbers_to_letters
    final_message
  end

  def decrypted_index
    message_grouped_by_four = character_index.each_slice(4).to_a
    decrypted_index = []
    message_grouped_by_four.each do |four|
      four.each_with_index do |element, index|
        if !element.is_a? Integer
          decrypted_index << element 
        else
          decrypted_index << element - shift[index]
        end
      end
    end
    decrypted_index
  end

  def numbers_to_letters
    modified = decrypted_index
    modified = new_index if @status == "encryption"
    message = ""
    modified.each do |index| 
      if !index.is_a? Integer
        message << index
      else
        message << @alphabet[index%27]
      end
    end
    message
  end
end