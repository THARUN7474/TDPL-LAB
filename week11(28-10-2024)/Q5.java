class SavingsAccount {
    private int balance;

    public SavingsAccount(int initialBalance) {
        this.balance = initialBalance;
    }

    public synchronized void deposit(int amount) {
        balance += amount;
        System.out.println(Thread.currentThread().getName() + " deposited: " + amount + ", New balance: " + balance);
        notifyAll();
    }

    public synchronized void withdraw(int amount) throws InterruptedException {
        while (balance < amount) {
            System.out.println(Thread.currentThread().getName() + " waiting to withdraw: " + amount + ", Current balance: " + balance);
            wait();
        }
        balance -= amount;
        System.out.println(Thread.currentThread().getName() + " withdrew: " + amount + ", New balance: " + balance);
    }
}

class AccountHolder implements Runnable {
    private final SavingsAccount account;
    private final int amount;
    private final boolean deposit;

    public AccountHolder(SavingsAccount account, int amount, boolean deposit) {
        this.account = account;
        this.amount = amount;
        this.deposit = deposit;
    }

    @Override
    public void run() {
        try {
            if (deposit) {
                account.deposit(amount);
            } else {
                account.withdraw(amount);
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}

public class Q5 {
    public static void main(String[] args) {
        SavingsAccount account = new SavingsAccount(100);
        Thread depositor1 = new Thread(new AccountHolder(account, 50, true), "Depositor-1");
        Thread depositor2 = new Thread(new AccountHolder(account, 100, true), "Depositor-2");
        Thread withdrawer1 = new Thread(new AccountHolder(account, 30, false), "Withdrawer-1");
        Thread withdrawer2 = new Thread(new AccountHolder(account, 120, false), "Withdrawer-2");

        depositor1.start();
        depositor2.start();
        withdrawer1.start();
        withdrawer2.start();
    }
}
