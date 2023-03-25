#!/usr/bin/env/ruby
################################
# NAME: Michael Kausch
# ASSIGNMENT: Activity 5
# Course: CSUB - CS 3500
# Date: 03/24/2023
# File: act05.rb
###############################

# Enable tail-call optimization here
RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

# function to print array for debugging
def print_arr(arr)
	for val in arr do
		print "#{val} "
	end
	puts ""
end

#Defining fibonacci (Binet,s implementation) method
def fibonacci_binnet(n)

	#Binets Formula
	sqrt5 = Math.sqrt(5); 
	fibonacci_binnet = ( ((1 + sqrt5)**n) - ((1  - sqrt5)**n) ) / ((2**n) * sqrt5)
	fibonacci_binnet.round
end

#Defining helper to implement a Tail-Call Recursive Implementation
def fibonacci_helper( a, b, count )
	if count == 0
	  a
	else
	  fibonacci_helper( b, a + b , count - 1 )
	end
  end
#
  def fibonacci_tailrec( n )
	fibonacci_helper( 0, 1, n )
  end

# Binet Accuracy method - 
def binet_accuracy()
	n = 1

	while (fibonacci_binnet(n) == fibonacci_tailrec(n)) do
		n += 1
	end	

	n-1
end

# Recursive Function for QuickSort
##################################
# QuickSort algorith sorts in in O(n * lg(n)) time

def quicksort(array, from=0, to=nil)
    
	
	
	if to == nil
        # Sort the whole array, by default
        to = array.count - 1
    end

    if from >= to
        # Done sorting
        return
    end

    # Take a pivot value, at the far left
    pivot = array[from]

    # Min and Max pointers
    min = from
    max = to

    # Current free slot
    free = min

    while min < max
        if free == min # Evaluate array[max]
            if array[max] <= pivot # Smaller than pivot, must move
                array[free] = array[max]
                min += 1
                free = max
            else
                max -= 1
            end
        elsif free == max # Evaluate array[min]
            if array[min] >= pivot # Bigger than pivot, must move
                array[free] = array[min]
                max -= 1
                free = min
            else
                min += 1
            end
        else
            raise "Inconsistent state"
        end
    end

    array[free] = pivot

    quicksort array, from, free - 1
    quicksort array, free + 1, to
end


def tqs(array, from=0, to=nil)
    
	if to == nil
        # Sort the whole array, by default
        to = array.count - 1
    end

    while (from < to)

		## partition and sort around pivot
		# Take a pivot value, at the far left
		pivot = array[from]
		# Min and Max pointers
		min = from
		max = to
		# Current free slot
		free = min

		while min < max
			if free == min # Evaluate array[max]
				if array[max] <= pivot # Smaller than pivot, must move
					array[free] = array[max]
					min += 1
					free = max
				else
					max -= 1
				end
			elsif free == max # Evaluate array[min]
				if array[min] >= pivot # Bigger than pivot, must move
					array[free] = array[min]
					max -= 1
					free = min
				else
					min += 1
				end
			else
				raise "Inconsistent state"
			end
		end

		array[free] = pivot
		tqs(array, from, free - 1)
		from = free + 1
	end

end


# # Tail-Recursive Function for QuickSort
# ##################################

# def tail_quicksort(arr, low=0, high=arr.size-1)
# 	while low < high do
# 		r = partition(arr, low, high)
# 		# puts "pivot is #{q}"
# 		# puts "calling tail_quicksort with low: #{low} and high: #{q-1}"

# 		tail_quicksort(arr, low, high-1)
# 		# print_arr arr
# 		low = q+1
# 		# puts "new low: #{low}"
# 	end

# end

# def tail_quicksort2(arr, low=0, high=arr.size-1)
# 	while low < high do
# 		r = partition(arr, low, high)
# 		if (r - low < high - r) then # first half
# 			tail_quicksort2(arr, low, r-1)
# 			low = r+1 
# 		else
# 			tail_quicksort2(arr, r+1, low)
# 			high = r-1
# 		end

# 	end

# end




# def mike_quicksort(arr, low=0, high=arr.size-1)
# 	if (low < high) then
# 		p = partition(arr, low, high)
# 		mike_quicksort(arr, low, p-1)
# 		mike_quicksort(arr, p+1, high)
# 	end
# end


# # partition function to return pivot and do swaps

# def partition(arr, low, high)
# 	pivot = arr[low]

# 	i = low + 1
# 	j = high

# 	while true

# 		# decrease j index until we find a var that's less than pivot
# 		while i <= j && arr[j] >= pivot
# 			j -= 1 
# 		end

# 		#increase i until we find a var that's more than pivot
# 		while i <= j && arr[i] <= pivot
# 			i += 1
# 		end

# 		# swap if iterators haven't crossed
# 		if i <= j then
# 			arr[i], arr[j] = arr[j], arr[i]
# 		else
# 			break
# 		end

# 	end
	
# 	#swap j with pivot position
# 	arr[j], arr[low] = arr[low], arr[j]

# 	return j
# end


# Iterative implementation for Binary Search
############################################
# iterative implementation of binary search in Ruby search in O(lg(n)) time

def binary_search_iter(arr, el)
    max = arr.length - 1
    min = 0
  
    while min <= max # know that if the size difference between the min and the max is 0 or negative, we've gone through the whole array and did not find the element
        mid = (min + max) / 2
		if arr[mid] == el
			return mid
		elsif arr[mid] > el # if the mid is greater than element looking for, discount right side and focus on left
			max = mid - 1
		else # covers remaining logic, if mid is less than element looking for, discount left and focus on right
			min = mid + 1
		end
    end
  
    return nil # Returns nil if ekement is not found
end

# ############################################
# # tail recursive implementation for Binary Search
# ############################################

# def binary_search_recur(arr, x)
   
# 	first = 0
# 	last = arr.length-1
# 	mid = (arr.length/2).to_i
    
# 	if (arr[mid] == x)
# 		return mid
# 	elsif (arr[mid] < x )
# 		# check if last element
# 		puts arr.inspect
# 		if (arr.length == 1) then
# 			return -1
# 		end

# 		sub_array = arr[mid+1..last]
		

# 		return binary_search_recur(sub_array, x)
# 	elsif (arr[mid] > x)
# 		puts arr.inspect

# 		if (arr.length == 1) then
# 			return -1
# 		end

# 		sub_array = arr[first...mid]

# 		return binary_search_recur(sub_array, x)

# 	else
# 		return -1
# 	end
# end


############################################
# tail recursive implementation for Binary Search
############################################
# this is actually the typical binary search implementation because it
# doesn't require keeping stack space open as the last thing that
# needs to happen is the recursive call
def binary_search_tailrecur(arr, low, high, x)
   
    if high >= low then
		mid = ((high + low) / 2).to_int
	
		if (arr[mid] == x) then
			return mid
		end

		if (arr[mid] < x) then
			return binary_search_tailrecur(arr, mid+1, high, x)
		else
			return binary_search_tailrecur(arr, low, mid-1, x)
		end	
	end 

	return -1
end



############################################
# recursive implementation for Binary Search
############################################
# purposely keeps the stacks open until the recursion ends by assigning it
# to a variable
def binary_search_recur(arr, low, high, x)
   
	mid = ((high + low) / 2).to_int

	if high >= low then
		if (arr[mid] == x) then
			result = mid
		elsif (arr[mid] < x) then
			low = mid+1
			result = binary_search_recur(arr, low, high, x)
		elsif (arr[mid] > x) then
			high = mid-1
			result = binary_search_recur(arr, low, high, x)
		end
	else
		result = -1
	end

	return result
end



###########################################
# MAIN LOGIC
###########################################

#reading list 1 into an array
unsort_list1 = Array.new
unsort_list1 = File.read("list1.txt").split.map(&:to_i)
to_sort1 = unsort_list1.map(&:clone)

# #reading list 2 into an array
unsort_list2 = Array.new
unsort_list2 = File.read("list2.txt").split.map(&:to_i)
to_sort2 = unsort_list1.map(&:clone)

puts "Part 1:"
puts "**********"
puts "Ruby's implementation of Binet's formula is accurate until n = #{binet_accuracy}\n\n"



puts "Please input element to search: "
search_element = gets.to_i
puts "\n"




######################################################
##						SORTING						##
######################################################


# # time for quicksort list1
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
quicksort(to_sort1)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_professor_qs1 = ending - starting
to_sort1 = unsort_list1.map(&:clone)	# reset to the original unsorted list1

# # # time for tail quicksort list1
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
tqs(to_sort1)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_mike_qs1 = ending - starting

# time for quicksort list2
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
quicksort(to_sort2)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_mike_qs2 = ending - starting
to_sort2 = unsort_list2.map(&:clone) # reset to the original unsorted list2

# # time for tail quicksort list2
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
tqs(to_sort2)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_professor_qs2 = ending - starting



######################################################
##					SEARCHING						##
######################################################



# time for iterative binary search list1
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
iter1_pos = binary_search_iter(to_sort1, search_element)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_ibs1 = ending - starting

# time for recursive binary search list1
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
recur1_pos = binary_search_recur(to_sort1, 0, to_sort1.length, search_element)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_rbs1 = ending - starting

# time for tail recursive binary search list1
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
tail_recur1_pos = binary_search_tailrecur(to_sort1, 0, to_sort1.length, search_element)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_trbs1 = ending - starting


# time for iterative binary search list2
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
iter2_pos = binary_search_iter(to_sort2, search_element)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_ibs2 = ending - starting

# time for recursive binary search list2
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
recur2_pos = binary_search_recur(to_sort2, 0, to_sort2.length, search_element)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_rbs2 = ending - starting

# time for tail recursive binary search list2
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
tail_recur2_pos = binary_search_tailrecur(to_sort2, 0, to_sort2.length, search_element)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
time_trbs2 = ending - starting



puts "Part2: "
puts "**********\n"


puts "\n"
print "              Time to sort in seconds       				Time to sort in seconds\n"
print "List          Recursive QuickSort           				Tail Recursive Quicksort\n"
print "********      ************************      				**************************************\n"
puts  "List 1        #{time_professor_qs1.round(8)} seconds.\t\t\t\t\t #{time_mike_qs1.round(8)} seconds."
puts  "List 2        #{time_professor_qs2.round(8)} seconds.\t\t\t\t\t #{time_mike_qs2.round(8)} seconds."


puts "\n"
print "              Time to search in seconds\n"
print "List          Iterative Binary Search\n"
print "********      ************************\n"
puts  "List 1        Found #{search_element} at index #{iter1_pos} in #{time_ibs1.round(8)} seconds."
puts  "List 2        Found #{search_element} at index #{iter2_pos} in #{time_ibs2.round(8)} seconds."


puts "\n"
print "              Time to search in seconds\n"     				
print "List          Recursive Binary Search\n"          		
print "********      ************************\n"
puts  "List 1        Found #{search_element} at index #{recur1_pos} in #{time_rbs1.round(8)} seconds."
puts  "List 2        Found #{search_element} at index #{recur2_pos} in #{time_rbs2.round(8)} seconds."


puts "\n"
print "              Time to search in seconds\n"     				
print "List          Tail Recursive Binary Search\n"          		
print "********      ************************\n"
puts  "List 1        Found #{search_element} at index #{tail_recur1_pos} in #{time_trbs1.round(8)} seconds."
puts  "List 2        Found #{search_element} at index #{tail_recur2_pos} in #{time_trbs2.round(8)} seconds."
