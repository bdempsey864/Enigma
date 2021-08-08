require './lib/enigma'

enigma = Enigma.new
source_file = File.open("./lib/#{ARGV[0]}") 
message_decryption = enigma.decrypt(source_file.read, ARGV[2], ARGV[3])
File.new("./lib/#{ARGV[1]}", "w+").write(message_decryption[:decryption])
puts "Created '#{ARGV[1]}' with the key #{message_decryption[:key]} and date #{message_decryption[:date]}"

# ruby ./lib/decrypt.rb encrypted.txt decrypted.txt