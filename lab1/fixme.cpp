#include<iostream>
using namespace std;
int foo(int arr[], int l, int r, int x)
{if (r >= l) {int mid = l + (r - l) / 2;
if (arr[mid] == x)
return mid; if (arr[mid] > x)
return foo(arr, l, mid - 1, x);
return foo(arr, mid + 1, r, x);}
return -1;}
int main(void)
{int arr[] = { 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181 }; 
int i = 0; int n = sizeof(arr) / sizeof(arr[0]);
while(i != 1){ int x; int result; cout << "Type a fibonacci number less than 100: ";
cin >> x; result = foo(arr, 0, n - 1, x); if(result == -1){
cout << "The number you entered is not a fibonacci number, please try again!\n"; } else{
cout << "The number you typed is the " << result << "-th fibonacci number, good bye!\n"; i = i + 1; }
} return 0; }