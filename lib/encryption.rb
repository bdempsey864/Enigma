class Encryption
  attr_reader :message, 
              :key, 
              :date
  def initialize(data)
    @message = data[:message]
    @key = data[:key]
    @date = data.fetch(:date, format_date)
  end

  def format_date
    "#{Time.now.strftime("%m")}#{Time.now.strftime("%d")}#{Time.now.strftime("%y")}"
  end
end