import java.util.concurrent.*;
import java.util.List;
import java.util.ArrayList;

class DivisorCounter implements Callable<int[]> {
    private final int start;
    private final int end;

    public DivisorCounter(int start, int end) {
        this.start = start;
        this.end = end;
    }

    @Override
    public int[] call() {
        int maxDivisors = 0;
        int numberWithMaxDivisors = 0;
        for (int i = start; i <= end; i++) {
            int divisorCount = countDivisors(i);
            if (divisorCount > maxDivisors) {
                maxDivisors = divisorCount;
                numberWithMaxDivisors = i;
            }
        }
        return new int[]{numberWithMaxDivisors, maxDivisors};
    }

    private int countDivisors(int number) {
        int count = 0;
        for (int i = 1; i * i <= number; i++) {
            if (number % i == 0) {
                count += 2;
                if (i * i == number) {
                    count--;
                }
            }
        }
        return count;
    }
}

public class Q2 {
    public static void main(String[] args) throws InterruptedException, ExecutionException {
        int maxThreads = 8; 
        ExecutorService executor = Executors.newFixedThreadPool(maxThreads);
        int range = 100000 / maxThreads;
        long startTime = System.currentTimeMillis();
        List<Future<int[]>> futures = new ArrayList<>();

        for (int i = 0; i < maxThreads; i++) {
            int start = i * range + 1;
            int end = (i == maxThreads - 1) ? 100000 : start + range - 1;
            futures.add(executor.submit(new DivisorCounter(start, end)));
        }

        int maxDivisors = 0;
        int numberWithMaxDivisors = 0;

        for (Future<int[]> future : futures) {
            int[] result = future.get();
            if (result[1] > maxDivisors) {
                maxDivisors = result[1];
                numberWithMaxDivisors = result[0];
            }
        }

        executor.shutdown();
        long elapsedTime = System.currentTimeMillis() - startTime;
        System.out.println("Number with the largest number of divisors: " + numberWithMaxDivisors);
        System.out.println("Number of divisors: " + maxDivisors);
        System.out.println("Elapsed time: " + elapsedTime + "ms");
    }
}

