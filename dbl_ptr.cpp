#include <iostream>
using namespace std;

int main()
{
    int a = 5;
    int * int_ptr = &a;
    int ** dptr = &int_ptr;
    int * temp_ptr = *dptr;

    cout << "a address: " << &a << endl;
    cout << "int_ptr assigned to: " << int_ptr << endl; 
    cout << "int_ptr address: " << &int_ptr << endl;
    cout << "dptr assigned value: " << dptr << endl;
    cout << "dptr address: " << &dptr << endl;

    cout << "*dptr : " << *dptr << endl;


    return 0;
}
