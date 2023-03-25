#!/usr/bin/env ruby
################################
#Fibonacci Sequence
#Binet's Formula Implementation
#CS 3500
###############################

#Defining fibonacci (Binet,s implementation) method
	def fibonacci_binnet(n)

		#Binets Formula
		sqrt5 = Math.sqrt(5); 
		fibonacci_binnet = ( ((1 + sqrt5)**n) - ((1  - sqrt5)**n) ) / ((2**n) * sqrt5)

	end

#Getting input number from user
print "Input the n-th Fibonacci Number you would like to calculate: "

#reading input as a number
n = gets.chomp.to_i

#start time to calculate elpased time
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#Nothe that we need to roud the output to account for floating calculation errors
puts "The #{n}-th fiboancci number is: #{fibonacci_binnet(n).round()}"

#end time to calculate elpased time
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#calculating elpased time
time = ending - starting
puts "Time elapsed #{time} seconds"