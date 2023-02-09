//  Originally written by: Professor Morales
//  Modified By: Michael Kausch
//  ASGT: Activity 1
//  ORGN: CSUB - CMPS 3500
//  FILE: Makefile
//  DATE: 02/05/2023

#include <iostream>

using namespace std;

/* Recursive Binary Search Algorithm
   int arr[] - pre-sorted array of values
   left_index - left most index of the current search
   right_index - right most index of the current search
   val - the value to be searched

   return:
        if found: the index of the value 
        else: -1
*/

int binarySearchRecursive(int arr[], int left_index, int right_index, int val)
{
    if (right_index >= left_index) {

        int mid = left_index + (right_index - left_index) / 2;

        // fib number found 
        if (arr[mid] == val) {
            return mid; 
        }

        // search left half 
        if (arr[mid] > val) {
            return binarySearchRecursive(arr, left_index, mid - 1, val);
        }
        
        // search right half
        return binarySearchRecursive(arr, mid + 1, right_index, val);
    }

    // val not found
    return -1;
}

int main(void) 
{
    int fibonacci_nums[] = { 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 
                    377, 610, 987, 1597, 2584, 4181 }; 
    bool is_fib = 0; 
    int arr_size = sizeof(fibonacci_nums) / sizeof(fibonacci_nums[0]);

    // repeat until a fibonacci value is found
    while (!is_fib) { 

        int user_input, result; 

        // prompt and get user input
        cout << "Type a fibonacci number less than 100: ";
        cin >> user_input; 

        // recursive call to binary search algorithm
        result = binarySearchRecursive(fibonacci_nums, 0, arr_size - 1, user_input); 

        if (result == -1) {   // not a fibonacci number
            cout << "The number you entered is not a fibonacci number, "
                << "please try again!\n"; 
        } else {    // fib number found
            cout << "The number you typed is the " << result << 
                "-th fibonacci number, good bye!\n"; 
            
            is_fib = true; 
        }
    } 

    return 0; 
}
