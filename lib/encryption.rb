class Encryption
  attr_reader :message, 
              :key, 
              :date
  def initialize(data)
    @message = data[:message]
    @key = data.fetch(:key, format_key)
    @date = data.fetch(:date, format_date)
    @alphabet = ("a".."z").to_a << " "
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

  def encrypt
    key_hash = {}
    key_hash[:a_key] = key.split("")[0..1].join
    key_hash[:b_key] = key.split("")[1..2].join
    key_hash[:c_key] = key.split("")[2..3].join
    key_hash[:d_key] = key.split("")[3..4].join
    date_hash = {}
    offs = date.to_i**2
    date_hash[:a_offset] = offs.to_s[-4]
    date_hash[:b_offset] = offs.to_s[-3]
    date_hash[:c_offset] = offs.to_s[-2]
    date_hash[:d_offset] = offs.to_s[-1]
    shift_hash = {}
    shift_hash[:a_shift] = (key_hash[:a_key].to_i + date_hash[:a_offset].to_i).to_s
    shift_hash[:b_shift] = (key_hash[:b_key].to_i + date_hash[:b_offset].to_i).to_s
    shift_hash[:c_shift] = (key_hash[:c_key].to_i + date_hash[:c_offset].to_i).to_s
    shift_hash[:d_shift] = (key_hash[:d_key].to_i + date_hash[:d_offset].to_i).to_s
    require "pry"; binding.pry
  end
end