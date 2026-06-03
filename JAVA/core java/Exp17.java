class Car {
    String make;
    String model;
    int year;

    void displayDetails() {
        System.out.println("Make: " + make);
        System.out.println("Model: " + model);
        System.out.println("Year: " + year);
    }
}

class Exp17 {
    public static void main(String[] args) {
        Car car1 = new Car();

        car1.make = "Toyota";
        car1.model = "Innova";
        car1.year = 2023;

        car1.displayDetails();
    }
}