abstract class Account {
  final int _accountNumber;
  double _balance;

  Account(this._accountNumber, this._balance);

  void deposit(double amount) {
    _balance += amount;
  }

  void withdraw(double amount);
}

class SavingsAccount extends Account {
  final double interestRate;

  SavingsAccount(super.accountNumber, super.balance, this.interestRate);

  @override
  void withdraw(double amount) {
    if (amount > _balance) return;
    _balance -= amount;
    _balance += _balance * (interestRate / 100);
  }
}

class CurrentAccount extends Account {
  final double overdraftLimit;

  CurrentAccount(super.accountNumber, super.balance, this.overdraftLimit);

  @override
  void withdraw(double amount) {
    if (amount <= _balance + overdraftLimit) {
      _balance -= amount;
    } else {
      print('Insufficient funds.');
    }
  }
}

void main() {
  // Create a SavingsAccount instance with an interest Rate of 8%
  final int accountNumber = 12345;
  final double intialBalance = 1000;
  final double interestRate = 8;

  SavingsAccount savingsAccount = SavingsAccount(
    accountNumber,
    intialBalance,
    interestRate,
  );

  savingsAccount.deposit(500);
  savingsAccount.withdraw(200);

  // Create a CurrentAccount instance with overdraft limit of 1000
  final int accountNumber2 = 67890;
  final double initialBalance2 = 2000;
  final double overdraftLimit = 1000;

  CurrentAccount currentAccount = CurrentAccount(
    accountNumber2,
    initialBalance2,
    overdraftLimit,
  );

  currentAccount.deposit(800);
  currentAccount.withdraw(3000);
}
