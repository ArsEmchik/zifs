require 'colorize'
require 'prime'
primes = Prime.take_while {|p| p < 500 }
ksi1 = primes[rand(0..primes.size - 1)]
ksi2 = primes[rand(0..primes.size - 1)]
puts "ksi1: #{ksi1}\nksi2: #{ksi2}".blue
mod = ksi1 * ksi2
u = rand(10**5..10**6)
sequence = u.to_s(2)
alpha = rand(1..mod - 1)
beta = (alpha ** 2) % mod
puts "alpha: #{alpha}\nbeta: #{beta}".yellow
s = (sequence.count('1') + beta.to_s(2).count('1')).to_s(2)
a = (1..100).to_a.select{|r| r.gcd(mod) == 1}.shuffle.take(s.size)
puts "a: #{a}".cyan
t = (alpha * s.split('').map.with_index{|s, i| a[i] ** s.to_i}.reduce(:*)) % mod
puts "t: #{t}".magenta
b = a.map{|e| (1..mod - 1).find{|bi| bi*(e**2) % mod == 1}}
puts "b: #{b}".cyan
w = (t ** 2 * s.split('').map.with_index{|s, i| b[i] ** s.to_i}.reduce(:*)) % mod
puts "w: #{w}".magenta
h2 = (sequence.count('1') + w.to_s(2).count('1')).to_s(2)
puts "It's alive! Hashes are equal :)".send(s == h2 ? :green : :red)
