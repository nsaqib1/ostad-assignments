class Car {
  static int numberOfCars = 0;

  final String brand;
  final String model;
  final int year;
  double milesDriven = 0;

  Car({
    required this.brand,
    required this.model,
    required this.year,
  }) {
    numberOfCars++;
  }

  void drive(double miles) {
    milesDriven = miles;
  }

  double getMilesDriven() {
    return milesDriven;
  }

  String getBrand() {
    return brand;
  }

  String getModel() {
    return model;
  }

  int getYear() {
    return year;
  }

  int getAge() {
    const int currentYear = 2023;
    return currentYear - year;
  }
}

void main() {
  final Car car1 = Car(brand: 'Toyota', model: 'Camri', year: 2020);
  final Car car2 = Car(brand: 'Honda', model: 'Civic', year: 2018);
  final Car car3 = Car(brand: 'Ford', model: 'F-150', year: 2015);

  car1.drive(10000);
  car2.drive(8000);
  car3.drive(15000);

  print(
    'Car 1: ${car1.getBrand()} ${car1.getModel()} ${car1.getYear()} Miles: ${car1.getMilesDriven().round()} Age: ${car1.getAge()}',
  );
  print(
    'Car 2: ${car2.getBrand()} ${car2.getModel()} ${car2.getYear()} Miles: ${car2.getMilesDriven().round()} Age: ${car2.getAge()}',
  );
  print(
    'Car 3: ${car3.getBrand()} ${car3.getModel()} ${car3.getYear()} Miles: ${car3.getMilesDriven().round()} Age: ${car3.getAge()}',
  );
  print('Total number of cars created: ${Car.numberOfCars}');

// Final Output
// Car 1: Toyota Camri 2020 Miles: 10000 Age: 3
// Car 2: Honda Civic 2018 Miles: 8000 Age: 5
// Car 3: Ford F-150 2015 Miles: 15000 Age: 8
// Total number of cars created: 3
}
