class Barrier {
    private final int maxThreads;
    private int waitingThreads = 0;

    public Barrier(int maxThreads) {
        this.maxThreads = maxThreads;
    }
    
    public synchronized void sync() throws InterruptedException {
        waitingThreads++;
        if (waitingThreads < maxThreads) {
            wait();
        } else {
            waitingThreads = 0;
            notifyAll();
        }
    }
}

class BarrierTask implements Runnable {
    private final Barrier barrier;

    public BarrierTask(Barrier barrier) {
        this.barrier = barrier;
    }

    @Override
    public void run() {
        try {
            System.out.println(Thread.currentThread().getName() + " has reached the barrier.");
            barrier.sync();
            System.out.println(Thread.currentThread().getName() + " has crossed the barrier.");
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}

public class Q4 {
    public static void main(String[] args) {
        int numberOfThreads = 5;
        Barrier barrier = new Barrier(numberOfThreads);
        for (int i = 0; i < numberOfThreads; i++) {
            new Thread(new BarrierTask(barrier), "Thread-" + (i + 1)).start();
        }
    }
}
