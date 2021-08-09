# class SpecialChar
#   def initialize(message)
#     @message = message
#     @hash = Hash.new{|h,k| h[k] = Array.new}
#     @alpha = ('a'..'z').to_a << " "
#   end
  
#   def positions
#     @message.chars.each_with_index do |character, index|
#       if !@alpha.include?(character)
#         @hash[character] << index
#       end
#     end
#     @hash
#   end

#   def remove_chars
#     not_special_message = ""
#     @message.chars.each do |character|
#       if !@alpha.include?(character)
#         not_special_message << ""
#       else
#         not_special_message << character
#       end
#     end
#     not_special_message
#   end

#   def insert_chars
#     special_message = ""
#   end
# end