import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Q1 {
    private static final int MAX_NUMBER = 10000;

    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());
        Future<Result> future = executor.submit(new DivisorTask(1, MAX_NUMBER));

        try {
            Result result = future.get();
            System.out.println("Integer with the largest number of divisors: " + result.number);
            System.out.println("Number of divisors: " + result.divisorCount);
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        } finally {
            executor.shutdown();
        }
    }
}

class DivisorTask implements Callable<Result> {
    private final int start;
    private final int end;

    public DivisorTask(int start, int end) {
        this.start = start;
        this.end = end;
    }

    @Override
    public Result call() {
        int maxDivisors = 0;
        int numberWithMaxDivisors = 0;

        for (int i = start; i <= end; i++) {
            int divisors = countDivisors(i);
            if (divisors > maxDivisors) {
                maxDivisors = divisors;
                numberWithMaxDivisors = i;
            }
        }

        return new Result(numberWithMaxDivisors, maxDivisors);
    }

    private int countDivisors(int number) {
        int count = 0;
        for (int i = 1; i <= Math.sqrt(number); i++) {
            if (number % i == 0) {
                count++;
                if (i != number / i) count++;
            }
        }
        return count;
    }
}

class Result {
    int number;
    int divisorCount;

    public Result(int number, int divisorCount) {
        this.number = number;
        this.divisorCount = divisorCount;
    }
}
