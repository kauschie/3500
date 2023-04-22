// Name - Michael Kausch
// Date - 4/19/23
// class - CSUB CMPS 3500
// Originally written by Professor Morales
// Works with Account.java

import java.io.*;     // import everything having to do with I/O
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;

public class AccountMain {

    public static Account a1 = new Account(50);
    public static Account a2 = new Account(50);
    public static double amount;
    // private static boolean keep_going = true;
    private static InputStreamReader isr = new InputStreamReader( System.in );
    private static BufferedReader stdin = new BufferedReader(isr);
    public static DecimalFormat df = new DecimalFormat();


    public static void printBalance()
    {
        df.setMinimumFractionDigits(2);
        df.setMinimumFractionDigits(2);
        System.out.println("Current Balances:");
        System.out.println("*****************");
        System.out.println("Account 1 Balance: $" + df.format(a1.getBalance()));
        System.out.println("Account 2 Balance: $" + df.format(a2.getBalance()));
    }

    public static double getAmount()
    {
        return amount;
    }

    public static void main(String[] args) throws IOException
    {
        // AccountMain m = new AccountMain();


        System.out.println("oOo  Part 2  oOo");
        // System.out.println("~~>Acount Obj<~~");
        System.out.println("****************\n");
        

        printBalance();
        
        // account 1 deposit prompt
        System.out.println("Enter deposit amount for account 1: ");
        // String buff  = stdin.readLine();  // clear input buffer from earlier read 
        String str = stdin.readLine();
        amount = Double.parseDouble(str);   // convert to double
        System.out.println("Adding " + df.format(amount) + " to account 1 balance");
        a1.credit(amount); 
        
        printBalance();

        // account 2 deposit prompt
        System.out.println("Enter deposit amount for account 2: ");
        // get amount
        // TODO: getAmount()
        str = stdin.readLine();
        amount = Double.parseDouble(str);   // convert to double
        System.out.println("Adding " + df.format(amount) + " to account 2 balance");
        a2.credit(amount);   

        printBalance();

        // account 1 sub prompt
        System.out.println("Enter debit amount for account 1: ");
        // get amount
        // TODO: getAmount()
        str = stdin.readLine();
        amount = Double.parseDouble(str);   // convert to double
        System.out.println("Subtracting " + df.format(amount) + " from account 1 balance\n");
        a1.debit(amount); 
        
        printBalance();

        // account 2 sub prompt
        System.out.println("Enter debit amount for account 2: ");
        // get amount
        // TODO: getAmount()
        str = stdin.readLine();
        amount = Double.parseDouble(str);   // convert to double
        System.out.println("Subtracting " + df.format(amount) + " from account 2 balance\n");
        a2.debit(amount);   

        printBalance();

    }
}
