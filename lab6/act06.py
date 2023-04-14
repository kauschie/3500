#!/usr/bin/env python
"""
Name: Michael Kausch
Date: 4/13/23
Activity 6
CSUB - Programming Languages CMPS 3500
Original Code by Professor Morales


CMPS 3500 act06

Execute with:

     python3 act06.py act06.data

act06.data is structured like this:

      401
      867
      53
      875
      .
      .
      .
"""

from sys import argv
import re
import math

"""
my_map takes a function and a list, and returns the result of the
function applied to the every element in the list; e.g.,

    my_map(lambda x: x + 1, [1, 2, 3])

returns [2, 3, 4]
"""

def my_map(func, list):
  new_list = []
  for item in list:
    new_list.append(func(item))
  return new_list

def log_processing(fname):
  input = open(fname, "r")
  ip_addresses = dict()
  # sorted_ips = list()
  total_bytes = 0
  rows_read = 0
  
  
  # go through every line in file
  for line in input:
    # use regex to extract ip and bytes to ip
    rows_read = rows_read + 1
    ip = re.findall("([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).*200 ([0-9]+)",line)
    byte_info = re.findall("200 ([0-9]+)",line)
    
    # print(len(ip))
    # print(ip[0])
    if (len(ip) < 1):
      # print("len was < 0")
      continue

    
    # grab frequencies of ip addresses to dict
    ip_addresses[ip[0][0]] = ip_addresses.get(ip[0][0],0) + 1
    
    try:
      total_bytes = total_bytes + int(byte_info[0])
    except:
      print (f"could not add {byte_info[0]}")
  
  
  # list comprehension to generate sorted list of all items in dict
  sorted_ips = sorted([(v,k) for (k,v) in ip_addresses.items()], reverse=True)
  
  
  
  print("Part 1.")
  print("***************************")
  print(f"lines read: {rows_read}")
  # print(f"total columns read: ")
  
  print(f"\n\nTotal Bytes Transferred: ((( {total_bytes} )))\n\n")
  
  print(f"***The 5 Most Common IP Addresses***\n")
  print(f"***     IP\t----\tCount ***")
  for i in range(5):
    print(f"{sorted_ips[i][1]}\t----\t{sorted_ips[i][0]}")
  
  input.close()
  
"""returns the mean of the values passed in by data_list with 
    filter (foo) applied"""
def my_mean(foo, data_list):
  # accumulator = 0
  good_vals = [val for val in data_list if foo(val)]
  accumulator = sum(good_vals)
  # print("Sum: ", accumulator)
  # print("Num: ", len(good_vals))
  # print("Avg: ", accumulator/len(good_vals))
  return (accumulator/len(good_vals))

"""Returns the standard deviation of a list of values
      with foo filter applied to the data"""
def my_sd(foo, data_list):
  good_vals = [val for val in data_list if foo(val)]
  sigma = 0
  mu = my_mean(foo, data_list)
  
  for xi in good_vals:
    sigma = sigma + ((xi-mu)**2)
  
  return (math.sqrt(sigma / len(good_vals)))
  
  
"""Returns a sorted list of vals with filter applied"""
def my_filter(foo, data_list):
  filtered_vals = [val for val in data_list if foo(val)]
  return sorted(filtered_vals)

def main(argv):
  if len(argv) < 2:
    try:
      log_processing("access.log")
    except:
      print("could not find default access.log")
      print("Usage: %s <filename>" % argv[0])
      print("continueing with the rest of the prog")
  else:
    log_processing(argv[1])
  
  vals = list()
  
  # get list of values from text file
  try:
    with open('act06.data', "r") as fin:
        vals = [int(line) for line in fin]
    
    
    print("\n\nPart 2.")
    print("***************************")
    print("\nOriginal List: ", vals)
    print("\nEvens: ", my_filter(lambda x: (x % 2) == 0, vals))
    
    print("\nMean of vals is: ", my_mean(lambda x: x > 0, vals))
    print("stdev of vals is: ", my_sd(lambda x: x > 0, vals))
    
    
    
    
    
    # print("Here's the even values from the file:")
    # Different way of printing it in groups of 10:
    # line_count = 0
    
    # for val in my_filter(lambda x: (x % 2) == 0, vals):
    #   print(val, end=" ")
    #   line_count = line_count+1
    #   if (line_count % 10 == 0):
    #     print()
    #     line_count = 0
    
    # print()
        
  except:
    print("error loading vals or opening file")
    

    

  # print("\nPrint values in file:")
  # print("=====================")
  # print(values)
  # print("\nPrint the square of the values in file:")
  # print("=========================================")
  # squared = my_map(lambda x: x * x, values)
  # print(squared)
  # print("\nPrint the successor (value + 1) of the values in file:")
  # print("========================================================")  
  # successor = my_map(lambda x: x + 1, values)
  # print(successor)

if __name__ == '__main__':
    main(argv)