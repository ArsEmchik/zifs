require 'prime'
require 'colorize'

def calc_d(e, f_n)
  d = 1
  d += 1 while (d * e) % f_n != 1
  return d
end

primes = Prime.take_while {|p| p < 500 }
message = "133 253 451"
puts "message: #{message}".green
m = message.split(' ')
p = primes[rand(0..primes.size - 1)]
q = primes[rand(0..primes.size - 1)]
n = p * q

puts '='.red * 80
puts "N: #{n}, p: #{p}, q: #{q}".blue
puts '='.red * 80

f_n = (p - 1) * (q - 1)
puts "F(N): #{f_n}".yellow
e = (2..f_n-1).to_a.shuffle.select {|e| e.gcd(f_n) == 1 }.first
puts "e: #{e}".yellow
d = calc_d(e, f_n)
puts "d: #{d}".yellow

m1 = []
c = []
m.each do |el_m|
  temp = (el_m.to_i ** e) % n
  c.push temp
  m1.push ((temp ** d % n).to_s
end

m1 = m1.join(' ')

if m1 == message
  puts "Correct message: #{m1}".green
else
  puts "Incorrect message: #{m1}".red
end
