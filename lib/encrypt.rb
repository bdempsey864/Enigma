require './lib/enigma'

message_file = ARGV[0]
file = File.open("./lib/#{message_file}")
message = file.read  
enigma = Enigma.new
message_encryption = enigma.encrypt(message)
target_file = ARGV[1]
encrypted_file = File.new("./lib/#{target_file}", "w+")


