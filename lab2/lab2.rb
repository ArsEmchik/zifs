Dir[File.expand_path('../lib/**/*.rb', __FILE__)].each {|f| require f}
require 'rubygems'
require 'colorize'

P = 97

a = Client.new(P)
b = Client.new(P)

puts "P=#{P}"
puts "Client A params: a: #{a.secret}, \u03B1: #{a.coeff}"
puts "Client B params: b: #{b.secret}, \u03B2: #{b.coeff}"

msg = Message.new(P)
$mu = msg.state
puts "mu: #{msg.state}"
a.send_message(msg)
puts "mu1: #{msg.state}"
b.send_message(msg)
puts "mu2: #{msg.state}"
mu2 = msg.state
a.resend_message(msg)
puts "mu3: #{msg.state}"
b.resend_message(msg)
puts "mu4: #{msg.state}"

if msg.state == msg.content
  puts "mu4 == mu is correct".green
else
  puts "mu4 != mu is not correct".red
end

$beta = b.coeff

puts "=".cyan * 40
puts "Params".cyan
puts "=".cyan * 40

spy = Spy.new(P, mu2)
right = {a: a.secret, alpha: a.coeff, b: b.secret, beta: b.coeff, mu: msg.content}

spy.variants.each do |v|
  if v == right
    puts v.inspect.green + " is correct"
  else
    puts v.inspect.red + " is not correct"
  end
end
