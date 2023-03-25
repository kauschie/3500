#!/usr/bin/env ruby
######################################
#Fibonacci Sequence
#Traditional Recursive Implementation
#CS 3500
######################################

#Defining fibonacci (Traditional Recursive Implementation) method
	def fibonacci_rec(n)
		#If n is 1, output 1
		if n == 1
			1
		#If n is 2, output 1	
		elsif n == 2
			1
		#If n > 2, the output will be the sum the previous two values
		else
			fibonacci_rec(n-1) + fibonacci_rec(n-2)
		end
	end
#Getting input number from user
print "Input the n-th Fibonacci Number you would like to calculate: "

#reading input as a number
n = gets.chomp.to_i

#start time to calculate elpased time
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#No rounding necessary
puts "The #{n}-th fiboancci number is: #{fibonacci_rec(n)}"

#end time to calculate elpased time
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#calculating elpased time
time = ending - starting
puts "Time elapsed #{time} seconds"