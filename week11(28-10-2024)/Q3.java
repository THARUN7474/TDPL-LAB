class MuseumControl {
    private boolean open = false;
    private int visitorsInside = 0;

    public synchronized void openMuseum() {
        open = true;
        System.out.println("Museum is now open.");
        notifyAll();
    }

    public synchronized void enterMuseum() throws InterruptedException {
        while (!open) {
            wait();
        }
        visitorsInside++;
        System.out.println("Visitor entered. Visitors inside: " + visitorsInside);
    }

    public synchronized void exitMuseum() throws InterruptedException {
        while (visitorsInside == 0) {
            wait();
        }
        visitorsInside--;
        System.out.println("Visitor exited. Visitors inside: " + visitorsInside);
        notifyAll();
    }

    public synchronized void closeMuseum() {
        open = false;
        System.out.println("Museum is now closed. Only exits allowed.");
        notifyAll();
    }

    public synchronized boolean isEmpty() {
        return visitorsInside == 0;
    }
}

class Director implements Runnable {
    private final MuseumControl control;

    public Director(MuseumControl control) {
        this.control = control;
    }

    @Override
    public void run() {
        try {
            control.openMuseum();
            Thread.sleep(5000);
            control.closeMuseum();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}

class East implements Runnable {
    private final MuseumControl control;
    private final int maxVisitors;

    public East(MuseumControl control, int maxVisitors) {
        this.control = control;
        this.maxVisitors = maxVisitors;
    }

    @Override
    public void run() {
        try {
            int enteredVisitors = 0;
            while (enteredVisitors < maxVisitors) {
                control.enterMuseum();
                enteredVisitors++;
                Thread.sleep(1000);
            }
            System.out.println("Maximum visitors have entered. East thread stopping.");
        } catch (InterruptedException e) {
            System.out.println("East thread interrupted.");
        }
    }
}

class West implements Runnable {
    private final MuseumControl control;

    public West(MuseumControl control) {
        this.control = control;
    }

    @Override
    public void run() {
        try {
            while (true) {
                control.exitMuseum();
                if (control.isEmpty()) {
                    System.out.println("All visitors have exited. West thread stopping.");
                    break;
                }
                Thread.sleep(1500);
            }
        } catch (InterruptedException e) {
            System.out.println("West thread interrupted.");
        }
    }
}

public class Q3 {
    public static void main(String[] args) {
        MuseumControl control = new MuseumControl();
        Thread director = new Thread(new Director(control));
        Thread east = new Thread(new East(control, 10));
        Thread west = new Thread(new West(control));

        director.start();
        east.start();
        west.start();
        
        try {
            director.join();
            west.join();
            if (control.isEmpty()) {
                east.interrupt();
            } else {
                east.join();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("Simulation finished.");
    }
}
