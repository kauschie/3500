#!/usr/bin/env ruby
######################################
#Fibonacci Sequence
#Tail-Call Recursive Implementation
#CS 3500
######################################




#Getting input number from user
print "Input the n-th Fibonacci Number you would like to calculate: "

#reading input as a number
n = gets.chomp.to_i

#start time to calculate elpased time
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#No rounding necessary
puts "The #{n}-th fiboancci number is: #{fibonacci_tailrec(n)}"

#end time to calculate elpased time
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

#calculating elpased time
time = ending - starting
puts "Time elapsed #{time} seconds"
