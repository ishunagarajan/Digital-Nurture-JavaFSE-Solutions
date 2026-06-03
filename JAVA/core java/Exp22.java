import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

class Exp22 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter text to write into file: ");
        String text = sc.nextLine();

        try {
            FileWriter fw = new FileWriter("output.txt");
            fw.write(text);
            fw.close();

            System.out.println("Data written to output.txt successfully");
        } catch (IOException e) {
            System.out.println("File writing error");
        }
    }
}