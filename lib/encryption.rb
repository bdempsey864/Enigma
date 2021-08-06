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
    
    
  end
end