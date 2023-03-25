#!/usr/bin/ruby
####################################################################################
# Course: CMPS3500
# Description: This Ruby script implements a the quicksort algorithm recursivelly
#####################################################################################

require 'csv'

# Enable tail-call optimization here
RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}


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

#######################
# Constructing Ouput
#######################

#reading list 1 into an array
list1 = Array.new
list1 = File.read("list1.txt").split.map(&:to_i)

list2 = Array.new
list2

# time for quicksort list1
starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
quicksort(list1)
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
timeQ1 = ending - starting

# time for binary search
to_search = 740620 # Element to search

starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
resbi = binary_search_iter(list1, to_search.to_i)  #list 1 must be sorted 
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
timeQ2 = ending - starting


puts "\n"
print "              Time to sort in seconds       Time to search an element in seconds\n"
print "List          Recursive QuickSort           Recursive Binary Search\n"
print "********      ************************      **************************************\n"
puts  "List 1        #{timeQ1.round(8)} seconds.          #{resbi.nil? ? " Could not find #{to_search} in " : " Found #{list1[resbi]} at index #{resbi} in "}#{timeQ2.round(8)} seconds."
puts "\n"
