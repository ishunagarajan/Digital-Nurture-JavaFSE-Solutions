import java.util.Scanner;
import java.util.Random;

class Exp10 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Random rand = new Random();

        int number = rand.nextInt(100) + 1;
        int guess;

        do {
            System.out.print("Guess the number: ");
            guess = sc.nextInt();

            if (guess > number)
                System.out.println("Too high");
            else if (guess < number)
                System.out.println("Too low");
            else
                System.out.println("Correct guess!");
        } while (guess != number);
    }
}