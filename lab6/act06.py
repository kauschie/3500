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
import sys

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






def printjob(name):              
  # name += " "
  sys.stdout.write(f"{name[0]},{name[1]} ") 

"""
+  CONSUMER 
+  'yield stuff' passes stuff back to the producer; when control resumes a 
+  message (it may be empty) is available from the producer as the return 
+  value from yield; note: cannot remove everything from the list since
+  the dereference to jobs[i] in yield is invalid
"""
def consumer(jobs):
  print("Consumer starting.")

  i = -1 

  # as long as something is in the jobs list keep processing requests
  while jobs:
    i = (i + 1) % len(jobs)
    # yield passes control back to producer with the ith job name
    getRequest = yield jobs[i]    # waits for request from producer

    if getRequest:    # if getRequest is not empty process it
      request, name, job_no = getRequest
      if request == "add":
        jobs.append((name, job_no))
        sys.stdout.write("\nADD ") 
      elif request == "remove" and (name, job_no) in jobs:
        jobs.remove((name, job_no))
        sys.stdout.write(f"\nREMOVE {name},{job_no}\n")

  print ("\nNo jobs left to do!\n")


def producer(jobs):
  print("Producer starting.")
  con = consumer(jobs)
  
  # buf = "Initial job list (" + str(len(jobs)) + "): "
  # sys.stdout.write(buf)
  for i in range(len(jobs)): 
    printjob(next(con))  # next sends job to consumer w/ no msg 
  
  printjob(con.send(("add", "iron", 44)))  # send sends job to consumer w/ msg
  sys.stdout.write("\n")
  for i in range(len(jobs)): 
    printjob(next(con))               

  # printjob(con.send(("add", "mend", 55)))   
  # sys.stdout.write("\n")
  # for i in range(len(jobs)): 
  #   printjob(next(con))               

  con.send(("remove","iron", 44))
  for i in range(len(jobs)): 
    printjob(next(con))

  # con.send(("remove","wash", 11))
  # for i in range(len(jobs)): 
  #   printjob(next(con))

  print ("\nProducer Done.")





def main(argv):
  
  int_arg = 0
  
  # having fun with some error checking
  if len(argv) == 1:
    try:
      log_processing("access.log")
    except:
      print("could not find local access.log")
      print(f"Usage: ./{argv[0]} <file_path_to_access.log> <int #>")
      print("continuing with the rest of the prog with default args")
  elif len(argv) == 2:
    print("only passed in 1 argument")
    print("checking if int")
    try:
      int_arg = int(argv[1])
      print("arg was an int")
      print("attempting to find/process access.log in local dir")
      try:
        log_processing("access.log")
      except:
        print("could not find default access.log")
        print(f"Usage: ./{argv[0]} <file_path_to_access.log> <int #>")
        print("continuing with the rest of the prog with default args")
    except:
      print(argv[1], "is not an int, running with defaul val of 0")
      int_arg = 0
      
      try:
        print("attempting to arg as access.log path")
        log_processing(argv[1])
        
      except:
        print(f"could not handle {argv[1]} as filepath to access.log")
        print(f"attempting to use find access.log in local dir...")
        try:
          log_processing("access.log")
        except:
          print("could not find default access.log")
          print(f"Usage: ./{argv[0]} <file_path_to_access.log> <int #>")
          print("continuing with the rest of the prog with default args")
  elif len(argv) == 3:
    try:
      int_arg = int(argv[2])
      log_processing(argv[1])  
    except:
      print(f"checking backwards args")
      try:
        int_arg = int(argv[1])
        log_processing(argv[2])
      except:
        print(f"Bad args.")
        print(f"Usage: ./{argv[0]} <file_path_to_access.log> <int #>")
        print("Attempting default args")
      
        try:
          log_processing("access.log")
        except:
          print("could not find local access.log")
          print(f"Usage: ./{argv[0]} <file_path_to_access.log> <int #>")
          print("continuing with the rest of the prog with default args")
      
  else:
    print(f"Usage: ./{argv[0]} <file_path_to_access.log> <int #>")
    return
  
  
  vals = list()
  
  # Part 2
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
    
        
  except:
    print("error loading vals or opening file act06.data file")
    print("skipping this section")
  

  # part 3

  print(f"\n\nPart 3.")
  print("***************************")
  print(f"Cmdline arg: {int_arg}")
  
  jobs = [("wash", 11+int_arg),("dry",22+int_arg),("fold",33+int_arg)]        # mutable list

  # con = consumer(jobs)                   # start the consumer 
  producer(jobs)                   # start the producer
    

    


if __name__ == '__main__':
    main(argv)