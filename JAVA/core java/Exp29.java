import java.util.*;
import java.util.stream.*;

record Person(String name, int age) {}

class Exp29 {
    public static void main(String[] args) {

        Person p1 = new Person("Adhul", 21);
        Person p2 = new Person("Rahul", 25);
        Person p3 = new Person("Kiran", 18);

        List<Person> people = Arrays.asList(p1, p2, p3);

        System.out.println("All Persons:");
        people.forEach(System.out::println);

        System.out.println("\nAge > 20:");

        people.stream()
              .filter(p -> p.age() > 20)
              .forEach(System.out::println);
    }
}