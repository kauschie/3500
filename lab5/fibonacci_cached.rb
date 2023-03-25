#!/usr/bin/env ruby
######################################
#Fibonacci Sequence
#Cached Recursive Implementation
#CS 3500
######################################

#cache first two values of the sequence
@cache = {}; @cache[1] = 1; @cache[2] = 1 

#Defining fibonacci (Cached Recursive Implementation) method
	def fibonacci_cached(n)
		#fibonacci sequence constructor 
		@cache[n] ||= fibonacci_cached(n-1) + fibonacci_cached(n-2)
	end
#Getting input number from user
print "Input the n-th Fibonacci Number you would like to calculate: "

#reading input as a number
n = gets.chomp.to_i

#start time to calculate elpased time
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#No rounding necessary
puts "The #{n}-th fiboancci number is: #{fibonacci_cached(n)}"

#end time to calculate elpased time
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#calculating elpased time
time = ending - starting
puts "Time elapsed #{time} seconds"