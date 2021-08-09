require './lib/enigma'

enigma = Enigma.new
source_file = File.open("./lib/#{ARGV[0]}") 
message_encryption = enigma.encrypt(source_file.read)
File.new("./lib/#{ARGV[1]}", "w+").write(message_encryption[:encryption])
puts "Created '#{ARGV[1]}' with the key #{message_encryption[:key]} and date #{message_encryption[:date]}"

# ruby ./lib/encrypt.rb message.txt encrypted.txt

