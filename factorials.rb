puts 'Enter N: '
n = gets.chomp.to_i
result = 1
(2..n).each do |val|
  result *= val
end

puts "N!= #{result}"
