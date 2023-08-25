abstract class Account {
  final int accountNumber;
  double balance;

  Account(this.accountNumber, this.balance);

  void deposit(double amount) {
    balance += amount;
  }

  void withdraw(double amount);
}

class SavingsAccount extends Account {
  final double interestRate;

  SavingsAccount(super.accountNumber, super.balance, this.interestRate);

  @override
  void withdraw(double amount) {
    if (amount > balance) return;
    balance -= amount;
    balance += balance * (interestRate / 100);
  }
}

class CurrentAccount extends Account {
  final double overdraftLimit;

  CurrentAccount(super.accountNumber, super.balance, this.overdraftLimit);

  @override
  void withdraw(double amount) {
    if (amount <= balance + overdraftLimit) {
      balance -= amount;
    } else {
      print('Insufficient funds.');
    }
  }
}

void main() {
  // Create a SavingsAccount instance with an interest Rate of 8%
  final int savingsAccountNumber = 12345;
  final double savingsAccountIntialBalance = 1000;
  final double savingsAccountInterestRate = 8;

  final SavingsAccount savingsAccount = SavingsAccount(
    savingsAccountNumber,
    savingsAccountIntialBalance,
    savingsAccountInterestRate,
  );

  print("Savings Account - account no: ${savingsAccount.accountNumber}");

  // Deposit operation on savings account instance
  final double savingsAccountDepositAmount = 500;
  savingsAccount.deposit(savingsAccountDepositAmount);
  print(
    "After deposit (${savingsAccountDepositAmount}): current balance: ${savingsAccount.balance}",
  );

  // Withdraw operation on savings account instance
  final double savingsAccountWithdrawAmount = 200;
  savingsAccount.withdraw(savingsAccountWithdrawAmount);
  print(
    "After withdraw (${savingsAccountWithdrawAmount}): current balance: ${savingsAccount.balance}\n",
  );

  // Create a CurrentAccount instance with overdraft limit of 1000
  final int currentAccountNumber = 67890;
  final double currentAccountInitialBalance = 2000;
  final double currentAccountOverdraftLimit = 1000;

  final CurrentAccount currentAccount = CurrentAccount(
    currentAccountNumber,
    currentAccountInitialBalance,
    currentAccountOverdraftLimit,
  );

  print("Current Account - account number: ${currentAccount.accountNumber}");

  // Deposit operation on current account instance
  final double currentAccountDepositAmount = 800;
  currentAccount.deposit(currentAccountDepositAmount);
  print(
    "After deposit (${currentAccountDepositAmount}): current balance: ${currentAccount.balance}",
  );

  // Withdraw operation on current account instance
  final double currentAccountWithdrawAmount = 3000;
  currentAccount.withdraw(currentAccountWithdrawAmount);
  print(
    "After withdraw (${currentAccountWithdrawAmount}): current balance: ${currentAccount.balance}",
  );

// FINAL OUTPUT
// Savings Account - account no: 12345
// After deposit (500.0): current balance: 1500.0
// After withdraw (200.0): current balance: 1404.0

// Current Account - account number: 67890
// After deposit (800.0): current balance: 2800.0
// After withdraw (3000.0): current balance: -200.0
}
