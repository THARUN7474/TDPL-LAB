public class Q1 {
    public static void main(String[] args) {
        int maxDivisors = 0;
        int numberWithMaxDivisors = 0;

        for (int i = 1; i <= 10000; i++) {
            int divisorCount = countDivisors(i);
            if (divisorCount > maxDivisors) {
                maxDivisors = divisorCount;
                numberWithMaxDivisors = i;
            }
        }
        
        System.out.println("Number with the largest number of divisors: " + numberWithMaxDivisors);
        System.out.println("Number of divisors: " + maxDivisors);
    }
    
    private static int countDivisors(int number) {
        int count = 0;
        
        for (int i = 1; i * i <= number;i++){
            if (number % i == 0){
                count += 2;
                if (i * i == number) {
                count--;
                }
            }
        }
        return count;
    }
}