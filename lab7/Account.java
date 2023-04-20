// Name - Michael Kausch
// Date - 4/19/23
// class - CSUB CMPS 3500
// Originally written by Professor Morales
// Works with MainAccount.java

public class Account {

    private double balance;

    public Account(double initialBalance)
    {
        if (initialBalance > 0.0) balance = initialBalance;
    }

    public void credit(double amount)
    {
        balance += amount;
    }

    public void debit(double amount)
    {
        if (balance >= amount) {
            balance -= amount;
        } else {
            System.out.println("<!><!><!> Debit amount exceeded account balance <!><!><!>\n");
        }
    }

    public double getBalance()
    {
        return balance;
    }

}
