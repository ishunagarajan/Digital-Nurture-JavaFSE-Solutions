import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Exp27 {
    public static void main(String[] args) {
        List<String> names = new ArrayList<>();

        names.add("Zara");
        names.add("Arun");
        names.add("Kumar");
        names.add("Bala");

        Collections.sort(names, (a, b) -> a.compareTo(b));

        System.out.println("Sorted List:");
        for (String name : names) {
            System.out.println(name);
        }
    }
}