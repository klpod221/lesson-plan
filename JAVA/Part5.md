---
prev:
  text: '🏆 SQL Final Project'
  link: '/SQL/FINAL'
next:
  text: '🏆 Java Final Project'
  link: '/JAVA/FINAL'
---

# 📘 PART 5: THREADS, MULTITHREADING AND JDBC

## 🎯 General Objectives

- Understand how to handle data input/output using Streams.
- Get familiar with Multithreading programming.
- Connect and manipulate data with databases using JDBC.

## 🧑‍🏫 Lesson 1: JAVA I/O Streams

### Concept of Streams in Java

- A Stream is a continuous sequence of data, read from a source or written to a destination. In Java, streams are managed through classes in the `java.io` package.

#### Basic Classification

1. **Byte Streams**: Handle 8-bit byte data.
   - Base classes: `InputStream` and `OutputStream`
   - Suitable for binary data like images, audio, video

2. **Character Streams**: Handle character data (Unicode).
   - Base classes: `Reader` and `Writer`
   - Suitable for text, configuration files

### Commonly Used Classes

#### Byte Streams

- `FileInputStream`/`FileOutputStream`: Read/write data from/to files
- `BufferedInputStream`/`BufferedOutputStream`: Optimize performance using buffers
- `DataInputStream`/`DataOutputStream`: Read/write primitive data types
- `ObjectInputStream`/`ObjectOutputStream`: Read/write objects (Serialization)

#### Character Streams

- `FileReader`/`FileWriter`: Read/write text from/to files
- `BufferedReader`/`BufferedWriter`: Optimize performance for character streams
- `InputStreamReader`/`OutputStreamWriter`: Convert between bytes and characters
- `PrintWriter`: Output formatted data

### Reading Files with InputStream and Reader

#### Reading Binary Files with FileInputStream

```java
public static void readBinaryFile(String filePath) {
    try (FileInputStream fis = new FileInputStream(filePath)) {
        int data;
        System.out.println("Reading binary data from file: " + filePath);
        
        // Read each byte until end of file (-1)
        while ((data = fis.read()) != -1) {
            System.out.print(data + " ");
        }
    } catch (FileNotFoundException e) {
        System.err.println("File not found: " + e.getMessage());
    } catch (IOException e) {
        System.err.println("Error reading file: " + e.getMessage());
    }
}
```

#### Reading Text Files with BufferedReader

```java
public static void readTextFile(String filePath) {
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        System.out.println("Reading text from file: " + filePath);
        
        // Read each line until end of file (null)
        while ((line = reader.readLine()) != null) {
            System.out.println(line);
        }
    } catch (FileNotFoundException e) {
        System.err.println("File not found: " + e.getMessage());
    } catch (IOException e) {
        System.err.println("Error reading file: " + e.getMessage());
    }
}
```

### Writing Files with OutputStream and Writer

#### Writing Binary Files with FileOutputStream

```java
public static void writeBinaryFile(String filePath, byte[] data) {
    try (FileOutputStream fos = new FileOutputStream(filePath)) {
        fos.write(data);
        System.out.println("Written " + data.length + " bytes to file: " + filePath);
    } catch (FileNotFoundException e) {
        System.err.println("Cannot create file: " + e.getMessage());
    } catch (IOException e) {
        System.err.println("Error writing file: " + e.getMessage());
    }
}
```

#### Writing Text Files with BufferedWriter

```java
public static void writeTextFile(String filePath, List<String> lines) {
    try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
        for (String line : lines) {
            writer.write(line);
            writer.newLine(); // Add newline character
        }
        System.out.println("Written " + lines.size() + " lines to file: " + filePath);
    } catch (IOException e) {
        System.err.println("Error writing file: " + e.getMessage());
    }
}
```

### Real-world Application: Copying Files with Buffer

```java
public static void copyFile(String sourceFile, String destinationFile) {
    try (FileInputStream fis = new FileInputStream(sourceFile);
         BufferedInputStream bis = new BufferedInputStream(fis);
         FileOutputStream fos = new FileOutputStream(destinationFile);
         BufferedOutputStream bos = new BufferedOutputStream(fos)) {
        
        byte[] buffer = new byte[4096]; // 4KB Buffer
        int bytesRead;
        
        // Read and write in buffer chunks
        while ((bytesRead = bis.read(buffer)) != -1) {
            bos.write(buffer, 0, bytesRead);
        }
        
        System.out.println("File copied successfully!");
        System.out.println("From: " + sourceFile);
        System.out.println("To: " + destinationFile);
        
    } catch (IOException e) {
        System.err.println("Error copying file: " + e.getMessage());
    }
}
```

### Serialization and Deserialization

Serialization is the process of converting an object into a byte stream for storage or transmission:

```java
// Student class must implement Serializable
public static void serializeObject(String filePath, Student student) {
    try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filePath))) {
        oos.writeObject(student);
        System.out.println("Saved Student object to file: " + filePath);
    } catch (IOException e) {
        System.err.println("Error saving object: " + e.getMessage());
    }
}

public static Student deserializeObject(String filePath) {
    try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filePath))) {
        Student student = (Student) ois.readObject();
        System.out.println("Read Student object from file: " + filePath);
        return student;
    } catch (IOException | ClassNotFoundException e) {
        System.err.println("Error reading object: " + e.getMessage());
        return null;
    }
}
```

### Handling Different Encodings

```java
public static void readFileWithEncoding(String filePath, String encoding) {
    try (BufferedReader reader = new BufferedReader(
            new InputStreamReader(new FileInputStream(filePath), encoding))) {
        
        String line;
        System.out.println("Reading file with encoding " + encoding + ":");
        
        while ((line = reader.readLine()) != null) {
            System.out.println(line);
        }
    } catch (UnsupportedEncodingException e) {
        System.err.println("Encoding not supported: " + encoding);
    } catch (IOException e) {
        System.err.println("Error reading file: " + e.getMessage());
    }
}
```

### Practice: Creating a Logger Application

```java
public class SimpleLogger {
    private static final String LOG_FILE = "application.log";
    private static PrintWriter writer;
    
    static {
        try {
            // Create writer for log file, append mode (true)
            writer = new PrintWriter(new BufferedWriter(new FileWriter(LOG_FILE, true)));
            
            // Add header on startup
            writer.println("=== Log started at: " + new Date() + " ===");
            writer.flush();
        } catch (IOException e) {
            System.err.println("Cannot initialize logger: " + e.getMessage());
        }
    }
    
    public static void log(String message) {
        String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        writer.println(timestamp + " - " + message);
        writer.flush();
    }
    
    public static void close() {
        if (writer != null) {
            writer.println("=== Log closed at: " + new Date() + " ===");
            writer.close();
        }
    }
}
```

## 🧑‍🏫 Lesson 2: Multithreading in JAVA

### Thread Concept and Benefits of Multithreading

**Thread** is the smallest unit of processing that can be scheduled by the operating system. A Java program runs in a separate process, but can have multiple threads executing concurrently within that process.

#### Benefits of Multithreading

1. **CPU Resource Utilization**: On multi-core systems, multiple threads can run in parallel.
2. **Increased Performance**: Perform multiple tasks simultaneously.
3. **Improved Responsiveness**: Keep user interface responsive while performing heavy tasks in background.
4. **Optimized Wait Time**: While one thread waits for I/O, other threads can continue execution.

### Creating Threads in Java

There are two main ways to create threads in Java:

#### 1. Extending Thread Class

```java
class MyThread extends Thread {
    @Override
    public void run() {
        // Code to be executed in new thread
        for (int i = 1; i <= 5; i++) {
            System.out.println("Thread [" + getName() + "]: Number " + i);
            try {
                // Pause thread for 1 second
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println("Thread interrupted");
                return;
            }
        }
        System.out.println("Thread [" + getName() + "] finished.");
    }
}

// Usage
public static void main(String[] args) {
    MyThread thread1 = new MyThread();
    thread1.setName("MyThread-1");
    thread1.start();  // Start new thread, calls run() method
    
    // Create and start another thread
    MyThread thread2 = new MyThread();
    thread2.setName("MyThread-2");
    thread2.start();
    
    System.out.println("Main thread continues execution...");
}
```

#### 2. Implementing Runnable Interface

```java
class MyRunnable implements Runnable {
    @Override
    public void run() {
        // Code to be executed in new thread
        String threadName = Thread.currentThread().getName();
        for (int i = 1; i <= 5; i++) {
            System.out.println("Thread [" + threadName + "]: Number " + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println("Thread interrupted");
                return;
            }
        }
        System.out.println("Thread [" + threadName + "] finished.");
    }
}

// Usage
public static void main(String[] args) {
    // Create Runnable object
    MyRunnable myRunnable = new MyRunnable();
    
    // Create thread with Runnable
    Thread thread1 = new Thread(myRunnable, "Thread-A");
    Thread thread2 = new Thread(myRunnable, "Thread-B");
    
    // Start threads
    thread1.start();
    thread2.start();
    
    System.out.println("Main thread continues execution...");
}
```

#### 3. Using Lambda Expressions (Java 8+)

```java
public static void main(String[] args) {
    // Create thread with lambda expression
    Thread thread = new Thread(() -> {
        String name = Thread.currentThread().getName();
        for (int i = 1; i <= 5; i++) {
            System.out.println("Thread [" + name + "]: Number " + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println("Thread interrupted");
                return;
            }
        }
        System.out.println("Thread [" + name + "] finished.");
    }, "Lambda-Thread");
    
    thread.start();
    System.out.println("Main thread continues execution...");
}
```

### Thread Management

#### Starting a Thread (start)

When `thread.start()` is called, the JVM allocates resources, schedules, and calls the `run()` method. The new thread runs in parallel with other threads.

```java
Thread thread = new Thread(() -> System.out.println("New thread running"));
thread.start(); // Start new thread
```

#### Waiting for Thread Completion (join)

The `join()` method causes the current thread to wait until another thread completes.

```java
Thread worker = new Thread(() -> {
    System.out.println("Worker started...");
    try {
        Thread.sleep(2000); // Simulate work taking 2 seconds
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    System.out.println("Worker finished!");
});

worker.start();
System.out.println("Main thread waiting for worker...");

try {
    worker.join(); // Main thread waits here until worker finishes
} catch (InterruptedException e) {
    e.printStackTrace();
}

System.out.println("Main thread continues after worker finished");
```

#### Pausing a Thread (sleep)

The `Thread.sleep(milliseconds)` method pauses the current thread for a specified duration.

```java
try {
    System.out.println("Starting pause...");
    Thread.sleep(3000); // Pause 3 seconds
    System.out.println("Continuing after pause!");
} catch (InterruptedException e) {
    System.out.println("Interrupted during sleep!");
}
```

#### Interrupting a Thread (interrupt)

The `interrupt()` method marks a thread as "interrupted" and is often used to request a thread to terminate early.

```java
Thread workerThread = new Thread(() -> {
    try {
        System.out.println("Worker thread started...");
        while (!Thread.currentThread().isInterrupted()) {
            System.out.println("Processing...");
            Thread.sleep(500);
        }
    } catch (InterruptedException e) {
        // Thread.sleep() throws InterruptedException when thread is interrupted
        System.out.println("Worker thread interrupted during sleep");
        return; // Exit run() method
    }
    System.out.println("Worker thread finished normally");
});

workerThread.start();

// Let thread run for 2 seconds
try {
    Thread.sleep(2000);
} catch (InterruptedException e) {
    e.printStackTrace();
}

// Interrupt thread
System.out.println("Main thread requesting worker to stop...");
workerThread.interrupt();
```

#### Thread Priority

You can set priority for threads (1-10, default is 5):

```java
Thread highPriorityThread = new Thread(() -> {
    // code...
});
highPriorityThread.setPriority(Thread.MAX_PRIORITY); // 10

Thread lowPriorityThread = new Thread(() -> {
    // code...
});
lowPriorityThread.setPriority(Thread.MIN_PRIORITY); // 1
```

### Synchronization

When multiple threads access a shared resource, data inconsistency (race condition) can occur. Synchronization ensures data integrity.

#### Race Condition Problem

```java
class Counter {
    private int count = 0;
    
    public void increment() {
        count++;  // Not thread-safe!
    }
    
    public int getCount() {
        return count;
    }
}

// Usage with multithreading
Counter counter = new Counter();
Runnable task = () -> {
    for (int i = 0; i < 10000; i++) {
        counter.increment();
    }
};

Thread t1 = new Thread(task);
Thread t2 = new Thread(task);

t1.start();
t2.start();

// Wait for both threads to finish
try {
    t1.join();
    t2.join();
} catch (InterruptedException e) {
    e.printStackTrace();
}

// Result might be less than 20000 due to race condition
System.out.println("Final value: " + counter.getCount());
```

#### Synchronization using synchronized keyword

```java
class SynchronizedCounter {
    private int count = 0;
    
    // Synchronized method - only one thread can enter at a time
    public synchronized void increment() {
        count++;
    }
    
    public synchronized int getCount() {
        return count;
    }
}

// Or using synchronized block
class SynchronizedCounter2 {
    private int count = 0;
    private final Object lock = new Object(); // Lock object
    
    public void increment() {
        // Only synchronize critical section
        synchronized(lock) {
            count++;
        }
    }
    
    public int getCount() {
        synchronized(lock) {
            return count;
        }
    }
}
```

#### Real-world Example: File Access Synchronization

```java
class FileLogger {
    private final String fileName;
    private final Object fileLock = new Object();
    
    public FileLogger(String fileName) {
        this.fileName = fileName;
    }
    
    public void logMessage(String message) {
        String threadName = Thread.currentThread().getName();
        String logEntry = new java.util.Date() + " - " + threadName + ": " + message;
        
        synchronized(fileLock) {
            try (java.io.PrintWriter writer = new java.io.PrintWriter(
                    new java.io.FileWriter(fileName, true))) {
                writer.println(logEntry);
            } catch (java.io.IOException e) {
                System.err.println("Error writing log: " + e.getMessage());
            }
        }
    }
}

// Usage
FileLogger logger = new FileLogger("application.log");

Runnable logTask = () -> {
    for (int i = 1; i <= 5; i++) {
        logger.logMessage("Record #" + i);
        try {
            Thread.sleep(200);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
};

// Create multiple threads logging together
new Thread(logTask, "Logger-A").start();
new Thread(logTask, "Logger-B").start();
new Thread(logTask, "Logger-C").start();
```

### Issues in Multithreading

#### Deadlock

Deadlock occurs when two or more threads wait for each other indefinitely.

```java
public static void demonstrateDeadlock() {
    final Object resource1 = new Object();
    final Object resource2 = new Object();
    
    // Thread 1: Acquires resource1, then tries to acquire resource2
    Thread t1 = new Thread(() -> {
        synchronized (resource1) {
            System.out.println("Thread 1: Acquired resource1");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            
            System.out.println("Thread 1: Trying to acquire resource2");
            synchronized (resource2) {
                System.out.println("Thread 1: Acquired resource2");
            }
        }
    });
    
    // Thread 2: Acquires resource2, then tries to acquire resource1
    Thread t2 = new Thread(() -> {
        synchronized (resource2) {
            System.out.println("Thread 2: Acquired resource2");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            
            System.out.println("Thread 2: Trying to acquire resource1");
            synchronized (resource1) {
                System.out.println("Thread 2: Acquired resource1");
            }
        }
    });
    
    t1.start();
    t2.start();
}
```

#### Avoiding Deadlock

One way to avoid deadlock is to always acquire resources in a specific order:

```java
public static void avoidDeadlock() {
    final Object resource1 = new Object();
    final Object resource2 = new Object();
    
    // Both threads acquire resource1 first, then resource2
    Thread t1 = new Thread(() -> {
        synchronized (resource1) {
            System.out.println("Thread 1: Acquired resource1");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            
            synchronized (resource2) {
                System.out.println("Thread 1: Acquired resource2");
            }
        }
    });
    
    Thread t2 = new Thread(() -> {
        synchronized (resource1) {
            System.out.println("Thread 2: Acquired resource1");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            
            synchronized (resource2) {
                System.out.println("Thread 2: Acquired resource2");
            }
        }
    });
    
    t1.start();
    t2.start();
}
```

### Real-world Example: Restaurant Simulation

```java
class Restaurant {
    private final Object kitchenLock = new Object();
    private int pendingOrders = 0;
    private final int MAX_PENDING_ORDERS = 5;
    
    // Chef cooks meals
    class Chef implements Runnable {
        @Override
        public void run() {
            while (true) {
                cookMeal();
                try {
                    // Time to cook a meal
                    Thread.sleep((int)(Math.random() * 1000) + 500);
                } catch (InterruptedException e) {
                    return;
                }
            }
        }
        
        private void cookMeal() {
            synchronized (kitchenLock) {
                if (pendingOrders == 0) {
                    try {
                        System.out.println("Chef: No orders, waiting...");
                        kitchenLock.wait(); // Wait for new order
                    } catch (InterruptedException e) {
                        return;
                    }
                }
                
                pendingOrders--;
                System.out.println("Chef: Finished a meal, remaining orders: " + pendingOrders);
                kitchenLock.notifyAll(); // Notify Waiter that meal is ready (conceptually)
            }
        }
    }
    
    // Waiter takes orders
    class Waiter implements Runnable {
        @Override
        public void run() {
            while (true) {
                takeOrder();
                try {
                    // Time to take an order
                    Thread.sleep((int)(Math.random() * 2000) + 1000);
                } catch (InterruptedException e) {
                    return;
                }
            }
        }
        
        private void takeOrder() {
            synchronized (kitchenLock) {
                if (pendingOrders >= MAX_PENDING_ORDERS) {
                    try {
                        System.out.println("Waiter: Kitchen overloaded, waiting...");
                        kitchenLock.wait(); // Wait until kitchen is less busy
                    } catch (InterruptedException e) {
                        return;
                    }
                }
                
                pendingOrders++;
                System.out.println("Waiter: Taken new order, current pending: " + pendingOrders);
                kitchenLock.notify(); // Notify Chef about new order
            }
        }
    }
    
    public void startSimulation() {
        Thread chefThread = new Thread(new Chef(), "Chef");
        Thread waiterThread = new Thread(new Waiter(), "Waiter");
        
        chefThread.start();
        waiterThread.start();
        
        // Run simulation for 10 seconds
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        // End threads
        chefThread.interrupt();
        waiterThread.interrupt();
        System.out.println("Restaurant simulation finished!");
    }
}
```

### Practice: Parallel File Downloader

```java
import java.io.*;
import java.net.*;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class ParallelDownloader {
    
    public static void main(String[] args) {
        String[] urls = {
            "https://example.com/file1.zip",
            "https://example.com/file2.pdf",
            "https://example.com/file3.jpg",
            "https://example.com/file4.mp4"
        };
        
        // Create destination directory
        File downloadDir = new File("downloads");
        if (!downloadDir.exists()) {
            downloadDir.mkdir();
        }
        
        System.out.println("Starting parallel download of " + urls.length + " files...");
        long startTime = System.currentTimeMillis();
        
        // Create ExecutorService with thread pool
        ExecutorService executor = Executors.newFixedThreadPool(3);
        
        // Create list of download tasks
        List<Future<DownloadResult>> results = new ArrayList<>();
        
        for (String url : urls) {
            // Create download task for each URL
            Callable<DownloadResult> downloadTask = new DownloadTask(url, downloadDir);
            
            // Submit task to executor and save Future to track
            Future<DownloadResult> future = executor.submit(downloadTask);
            results.add(future);
        }
        
        // Collect results
        for (Future<DownloadResult> future : results) {
            try {
                DownloadResult result = future.get(); // Wait for task to complete
                System.out.println("Downloaded: " + result.getFileName() + 
                                   " (" + result.getFileSize() + " bytes) in " + 
                                   result.getElapsedTime() + "ms");
            } catch (InterruptedException | ExecutionException e) {
                System.err.println("Error downloading file: " + e.getMessage());
            }
        }
        
        // Shutdown executor
        executor.shutdown();
        
        long endTime = System.currentTimeMillis();
        System.out.println("Completed! Total time: " + (endTime - startTime) + "ms");
    }
    
    static class DownloadTask implements Callable<DownloadResult> {
        private final String urlString;
        private final File downloadDir;
        
        public DownloadTask(String urlString, File downloadDir) {
            this.urlString = urlString;
            this.downloadDir = downloadDir;
        }
        
        @Override
        public DownloadResult call() throws Exception {
            long startTime = System.currentTimeMillis();
            
            URL url = new URL(urlString);
            String fileName = new File(url.getPath()).getName();
            File outputFile = new File(downloadDir, fileName);
            
            System.out.println("Thread [" + Thread.currentThread().getName() + 
                             "] downloading: " + fileName);
            
            long fileSize = 0;
            try (BufferedInputStream in = new BufferedInputStream(url.openStream());
                 FileOutputStream fos = new FileOutputStream(outputFile)) {
                
                byte[] buffer = new byte[4096];
                int bytesRead;
                
                while ((bytesRead = in.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                    fileSize += bytesRead;
                    
                    // Simulate slow network
                    Thread.sleep(10);
                }
            }
            
            long endTime = System.currentTimeMillis();
            return new DownloadResult(fileName, fileSize, endTime - startTime);
        }
    }
    
    static class DownloadResult {
        private final String fileName;
        private final long fileSize;
        private final long elapsedTime;
        
        public DownloadResult(String fileName, long fileSize, long elapsedTime) {
            this.fileName = fileName;
            this.fileSize = fileSize;
            this.elapsedTime = elapsedTime;
        }
        
        public String getFileName() {
            return fileName;
        }
        
        public long getFileSize() {
            return fileSize;
        }
        
        public long getElapsedTime() {
            return elapsedTime;
        }
    }
}
```

## 🧑‍🏫 Lesson 3: Concurrency

Concurrency is a technique that allows multiple tasks to be executed simultaneously, increasing performance and optimizing resource usage. Java provides powerful APIs to build efficient and safe concurrent applications.

### Concurrency API in Java

Java SE 5 introduced the `java.util.concurrent` package with classes and interfaces to manage threads more efficiently and safely than traditional methods.

#### ExecutorService and Thread Pool

`ExecutorService` is a service that helps manage threads and tasks. `ThreadPool` is a group of pre-created threads ready to perform work, helping to:

- Reuse threads, reducing initialization overhead
- Manage the number of concurrent threads
- Improve performance with appropriate thread count

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ExecutorServiceExample {
    public static void main(String[] args) {
        // Create thread pool with fixed size of 5 threads
        ExecutorService executor = Executors.newFixedThreadPool(5);
        
        // Submit 10 tasks to executor
        for (int i = 1; i <= 10; i++) {
            final int taskId = i;
            executor.execute(() -> {
                System.out.println("Executing task " + taskId + 
                                   " by thread " + Thread.currentThread().getName());
                try {
                    // Simulate time-consuming work
                    Thread.sleep((long)(Math.random() * 1000));
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
                System.out.println("Task " + taskId + " completed");
            });
        }
        
        // Shutdown executor after completion
        executor.shutdown();
        
        // Wait until all tasks are finished
        while (!executor.isTerminated()) {
            // Wait
        }
        
        System.out.println("All tasks completed");
    }
}
```

#### Common Executor Types

1. **Fixed Thread Pool**: Fixed number of threads

   ```java
   ExecutorService fixedPool = Executors.newFixedThreadPool(5);
   ```

2. **Cached Thread Pool**: Automatically creates new threads as needed, reuses idle threads

   ```java
   ExecutorService cachedPool = Executors.newCachedThreadPool();
   ```

3. **Single Thread Executor**: Uses only 1 single thread

   ```java
   ExecutorService singleThreadExecutor = Executors.newSingleThreadExecutor();
   ```

4. **Scheduled Thread Pool**: Allows scheduling tasks execution

   ```java
   ScheduledExecutorService scheduledPool = Executors.newScheduledThreadPool(3);
   ```

### Callable and Future

`Callable` is similar to `Runnable` but can return a result and throw exceptions.
`Future` is an object representing an asynchronous result, allowing to check status and retrieve result when completed.

```java
import java.util.concurrent.*;
import java.util.*;

public class CallableFutureExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(3);
        
        // List of Futures to store results
        List<Future<Integer>> resultList = new ArrayList<>();
        
        // Create and submit 5 Callable tasks
        for (int i = 1; i <= 5; i++) {
            final int taskId = i;
            Callable<Integer> task = () -> {
                System.out.println("Calculating task " + taskId);
                Thread.sleep(1000); // Simulate processing
                // Suppose calculating sum from 1 to taskId
                int sum = 0;
                for (int j = 1; j <= taskId; j++) {
                    sum += j;
                }
                return sum;
            };
            
            // Submit task and save Future
            Future<Integer> future = executor.submit(task);
            resultList.add(future);
        }
        
        // Process results
        for (int i = 0; i < resultList.size(); i++) {
            try {
                // get() will wait until task completes
                Integer result = resultList.get(i).get();
                System.out.println("Task " + (i + 1) + " result: " + result);
            } catch (InterruptedException | ExecutionException e) {
                e.printStackTrace();
            }
        }
        
        executor.shutdown();
    }
}
```

### CompletableFuture in Java 8+

`CompletableFuture` is a new class in Java 8, extending `Future` with many useful methods for asynchronous programming:

```java
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;

public class CompletableFutureExample {
    public static void main(String[] args) {
        // Create asynchronous CompletableFuture
        CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
            try {
                System.out.println("Processing task...");
                TimeUnit.SECONDS.sleep(2);
                return "Result from async task";
            } catch (InterruptedException e) {
                return "Task interrupted";
            }
        });
        
        // Add callback to handle result when completed
        future.thenAccept(result -> {
            System.out.println("Received result: " + result);
        });
        
        // Add error handling
        future.exceptionally(ex -> {
            System.out.println("Error occurred: " + ex.getMessage());
            return "Default value due to error";
        });
        
        // Combine two async tasks
        CompletableFuture<String> future1 = CompletableFuture.supplyAsync(() -> {
            try {
                TimeUnit.SECONDS.sleep(1);
                return "Data from source 1";
            } catch (InterruptedException e) {
                return "Error from source 1";
            }
        });
        
        CompletableFuture<String> future2 = CompletableFuture.supplyAsync(() -> {
            try {
                TimeUnit.SECONDS.sleep(2);
                return "Data from source 2";
            } catch (InterruptedException e) {
                return "Error from source 2";
            }
        });
        
        // Combine results from both sources
        CompletableFuture<String> combinedFuture = future1.thenCombine(future2, 
            (result1, result2) -> result1 + " + " + result2);
        
        combinedFuture.thenAccept(System.out::println);
        
        // Ensure program doesn't exit before tasks complete
        try {
            TimeUnit.SECONDS.sleep(5);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
```

### Advanced Synchronization with Lock Interface

Java provides the `Lock` interface in `java.util.concurrent.locks` package as an advanced solution for `synchronized` keyword:

```java
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class BankAccount {
    private double balance;
    private final Lock lock = new ReentrantLock();
    
    public BankAccount(double initialBalance) {
        this.balance = initialBalance;
    }
    
    public void deposit(double amount) {
        lock.lock();  // Lock resource
        try {
            if (amount > 0) {
                double newBalance = balance + amount;
                // Simulate delay to expose race condition
                Thread.sleep(100);
                balance = newBalance;
                System.out.println("Deposited: " + amount + ", New balance: " + balance);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            lock.unlock();  // Always ensure unlock in finally
        }
    }
    
    public boolean withdraw(double amount) {
        lock.lock();
        try {
            if (amount <= balance) {
                double newBalance = balance - amount;
                Thread.sleep(100);
                balance = newBalance;
                System.out.println("Withdrew: " + amount + ", New balance: " + balance);
                return true;
            }
            return false;
        } catch (InterruptedException e) {
            e.printStackTrace();
            return false;
        } finally {
            lock.unlock();
        }
    }
    
    public double getBalance() {
        lock.lock();
        try {
            return balance;
        } finally {
            lock.unlock();
        }
    }
    
    // Use tryLock to avoid deadlock
    public boolean transfer(BankAccount target, double amount) {
        // Try to lock source account
        if (lock.tryLock()) {
            try {
                // Try to lock target account
                if (target.lock.tryLock()) {
                    try {
                        if (amount <= balance) {
                            withdraw(amount);
                            target.deposit(amount);
                            return true;
                        }
                        return false;
                    } finally {
                        target.lock.unlock();
                    }
                }
            } finally {
                lock.unlock();
            }
        }
        // If cannot lock both accounts
        System.out.println("Cannot transfer at this time, please try again later");
        return false;
    }
}
```

### Semaphore and Latch

`Semaphore` controls the number of threads that can access a resource simultaneously:

```java
import java.util.concurrent.Semaphore;

public class SemaphoreExample {
    public static void main(String[] args) {
        // Simulate a connection pool with 3 connections
        Semaphore connectionPool = new Semaphore(3);
        
        // Create 10 threads accessing connection pool
        for (int i = 1; i <= 10; i++) {
            final int clientId = i;
            new Thread(() -> {
                try {
                    System.out.println("Client " + clientId + " waiting for connection...");
                    connectionPool.acquire(); // Acquire 1 permit (connection)
                    System.out.println("Client " + clientId + " acquired connection!");
                    
                    // Simulate connection usage time
                    Thread.sleep((long)(Math.random() * 2000) + 1000);
                    
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    // Release connection when done
                    connectionPool.release();
                    System.out.println("Client " + clientId + " released connection!");
                }
            }).start();
        }
    }
}
```

`CountDownLatch` is a synchronization aid that allows one or more threads to wait until a set of operations being performed in other threads completes:

```java
import java.util.concurrent.CountDownLatch;

public class CountDownLatchExample {
    public static void main(String[] args) throws InterruptedException {
        // Create latch with count of 3
        CountDownLatch latch = new CountDownLatch(3);
        
        System.out.println("Application starting...");
        
        // Start 3 services
        for (int i = 1; i <= 3; i++) {
            final int serviceId = i;
            new Thread(() -> {
                try {
                    System.out.println("Service " + serviceId + " starting...");
                    // Simulate startup time
                    Thread.sleep((long)(Math.random() * 2000) + 1000);
                    System.out.println("Service " + serviceId + " ready!");
                    
                    // Mark this service as completed
                    latch.countDown();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }).start();
        }
        
        // Wait until all 3 services are ready
        latch.await();
        
        System.out.println("All services ready! Application starting to process requests...");
    }
}
```

### Atomic Variables

Atomic variables in `java.util.concurrent.atomic` package provide atomic operations without locking:

```java
import java.util.concurrent.atomic.AtomicInteger;

public class AtomicVariableExample {
    // Traditional counter (not thread-safe)
    private static int normalCounter = 0;
    
    // Atomic counter (thread-safe)
    private static AtomicInteger atomicCounter = new AtomicInteger(0);
    
    public static void main(String[] args) throws InterruptedException {
        // Create multiple threads incrementing counter
        Thread[] threads = new Thread[10];
        
        for (int i = 0; i < threads.length; i++) {
            threads[i] = new Thread(() -> {
                for (int j = 0; j < 1000; j++) {
                    normalCounter++;         // Not safe, data loss possible
                    atomicCounter.incrementAndGet();  // Safe, atomic
                }
            });
            threads[i].start();
        }
        
        // Wait for all threads to complete
        for (Thread thread : threads) {
            thread.join();
        }
        
        System.out.println("Normal counter value: " + normalCounter);
        System.out.println("Atomic counter value: " + atomicCounter.get());
    }
}
```

### ConcurrentHashMap and CopyOnWriteArrayList

Concurrent Collections are designed specifically to work efficiently in multithreaded environments:

```java
import java.util.*;
import java.util.concurrent.*;

public class ConcurrentCollectionsExample {
    public static void main(String[] args) {
        // Normal HashMap (not thread-safe)
        Map<String, Integer> normalMap = new HashMap<>();
        
        // ConcurrentHashMap (thread-safe)
        Map<String, Integer> concurrentMap = new ConcurrentHashMap<>();
        
        // Normal ArrayList (not thread-safe)
        List<String> normalList = new ArrayList<>();
        
        // CopyOnWriteArrayList (thread-safe)
        List<String> concurrentList = new CopyOnWriteArrayList<>();
        
        // Create and run multiple threads accessing collections
        Runnable task = () -> {
            // Add element to list
            String threadName = Thread.currentThread().getName();
            concurrentList.add(threadName);
            
            // Update value in map
            concurrentMap.put(threadName, concurrentList.size());
            
            // Read all elements from list
            for (String item : concurrentList) {
                // Read operation is not blocked
                System.out.println(threadName + " read: " + item);
            }
            
            // Retrieve and update value in map
            concurrentMap.computeIfPresent(threadName, (key, oldValue) -> oldValue + 1);
        };
        
        // Start 10 threads
        List<Thread> threads = new ArrayList<>();
        for (int i = 1; i <= 10; i++) {
            Thread t = new Thread(task, "Thread-" + i);
            threads.add(t);
            t.start();
        }
        
        // Wait for all threads to complete
        for (Thread t : threads) {
            try {
                t.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        // Display results
        System.out.println("\nFinal Result:");
        System.out.println("ConcurrentList size: " + concurrentList.size());
        System.out.println("ConcurrentMap entries: " + concurrentMap);
    }
}
```

### Real-world Example: Parallel Data Processing

```java
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;

public class ParallelDataProcessingExample {
    
    // Simulate data to process
    private static List<String> generateData(int size) {
        List<String> data = new ArrayList<>(size);
        for (int i = 0; i < size; i++) {
            data.add("Item-" + i);
        }
        return data;
    }
    
    // Simulate time-consuming processing function
    private static String processItem(String item) {
        try {
            // Simulate processing time
            Thread.sleep(100);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        return item.toUpperCase() + "-PROCESSED";
    }
    
    public static void main(String[] args) throws InterruptedException, ExecutionException {
        // Create sample data
        List<String> rawData = generateData(100);
        
        System.out.println("Starting processing of " + rawData.size() + " items");
        
        // 1. Sequential processing
        long startTime = System.currentTimeMillis();
        List<String> sequentialResult = processSequentially(rawData);
        long sequentialTime = System.currentTimeMillis() - startTime;
        
        System.out.println("Sequential processing completed in " + sequentialTime + " ms");
        
        // 2. Processing with ExecutorService
        startTime = System.currentTimeMillis();
        List<String> executorResult = processWithExecutor(rawData);
        long executorTime = System.currentTimeMillis() - startTime;
        
        System.out.println("Processing with ExecutorService completed in " + executorTime + " ms");
        
        // 3. Processing with CompletableFuture
        startTime = System.currentTimeMillis();
        List<String> completableFutureResult = processWithCompletableFuture(rawData);
        long completableFutureTime = System.currentTimeMillis() - startTime;
        
        System.out.println("Processing with CompletableFuture completed in " + 
                         completableFutureTime + " ms");
        
        // 4. Processing with Parallel Streams (Java 8+)
        startTime = System.currentTimeMillis();
        List<String> parallelStreamResult = processWithParallelStream(rawData);
        long parallelStreamTime = System.currentTimeMillis() - startTime;
        
        System.out.println("Processing with Parallel Streams completed in " + 
                         parallelStreamTime + " ms");
        
        // Compare results
        boolean allResultsMatch = sequentialResult.equals(executorResult) && 
                               executorResult.equals(completableFutureResult) &&
                               completableFutureResult.equals(parallelStreamResult);
        
        System.out.println("All results match: " + allResultsMatch);
        System.out.println("\nSpeed improvement:");
        double executorSpeedup = (double) sequentialTime / executorTime;
        double completableFutureSpeedup = (double) sequentialTime / completableFutureTime;
        double parallelStreamSpeedup = (double) sequentialTime / parallelStreamTime;
        
        System.out.printf("- ExecutorService: %.2fx faster\n", executorSpeedup);
        System.out.printf("- CompletableFuture: %.2fx faster\n", completableFutureSpeedup);
        System.out.printf("- Parallel Streams: %.2fx faster\n", parallelStreamSpeedup);
    }
    
    // 1. Sequential processing
    private static List<String> processSequentially(List<String> data) {
        List<String> results = new ArrayList<>(data.size());
        for (String item : data) {
            results.add(processItem(item));
        }
        return results;
    }
    
    // 2. Processing with ExecutorService
    private static List<String> processWithExecutor(List<String> data) 
            throws InterruptedException, ExecutionException {
        
        ExecutorService executor = Executors.newFixedThreadPool(
            Runtime.getRuntime().availableProcessors());
        
        List<Future<String>> futures = new ArrayList<>(data.size());
        
        for (String item : data) {
            Future<String> future = executor.submit(() -> processItem(item));
            futures.add(future);
        }
        
        List<String> results = new ArrayList<>(data.size());
        for (Future<String> future : futures) {
            results.add(future.get());
        }
        
        executor.shutdown();
        return results;
    }
    
    // 3. Processing with CompletableFuture
    private static List<String> processWithCompletableFuture(List<String> data) {
        List<CompletableFuture<String>> futures = data.stream()
            .map(item -> CompletableFuture.supplyAsync(() -> processItem(item)))
            .collect(Collectors.toList());
        
        return futures.stream()
            .map(CompletableFuture::join)
            .collect(Collectors.toList());
    }
    
    // 4. Processing with Parallel Streams
    private static List<String> processWithParallelStream(List<String> data) {
        return data.parallelStream()
            .map(ParallelDataProcessingExample::processItem)
            .collect(Collectors.toList());
    }
}
```

### Best Practices

1. **Use ThreadPool instead of creating threads directly**
   - To efficiently manage and optimize thread usage in the application.

2. **Always release resources**
   - Always call `shutdown()` on `ExecutorService` when no longer needed.
   - Use try-with-resources or finally to ensure locks are unlocked.

3. **Avoid deadlock**
   - Always acquire locks in the same order.
   - Use tryLock() with timeout to avoid indefinite waiting.
   - Don't hold locks while performing blocking or long-running operations.

4. **Minimize shared state**
   - Design to minimize shared data.
   - Use local thread variables when possible.
   - Use `ThreadLocal` when separate state is needed for threads.

5. **Exception Handling**
   - Do not ignore exceptions in threads.
   - Log or propagate exceptions to higher levels.
   - Check InterruptedException and restore interrupted status.

6. **Understand Memory Consistency**
   - Use volatile variables for simple flags.
   - Use synchronized or Lock for complex state.
   - Prefer Atomic classes and Concurrent Collections.

7. **Consider Synchronization Cost**
   - Synchronization is only truly necessary when multiple threads write data.
   - Read-only operations do not need complex synchronization.
   - Use structures like ReadWriteLock when appropriate.

8. **Multithreading Testing**
   - Apply static analysis tools.
   - Write multithreaded tests with contention scenarios.
   - Perform stress testing to find performance issues.

### Practice Exercise: Building Parallel Document Indexer

```java
import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.*;

public class ParallelDocumentIndexer {
    
    // Store index: keyword -> list of documents
    private final ConcurrentMap<String, Set<String>> index = new ConcurrentHashMap<>();
    
    // Directory containing documents to index
    private final Path documentsDir;
    
    public ParallelDocumentIndexer(String documentsPath) {
        this.documentsDir = Paths.get(documentsPath);
    }
    
    public void buildIndex() throws IOException, InterruptedException {
        System.out.println("Starting indexing from directory: " + documentsDir);
        
        // Get list of all .txt files
        List<Path> textFiles = Files.walk(documentsDir)
                                .filter(p -> p.toString().endsWith(".txt"))
                                .collect(Collectors.toList());
        
        System.out.println("Found " + textFiles.size() + " documents");
        
        ExecutorService executor = Executors.newWorkStealingPool();
        
        // Create futures to track progress
        List<Future<?>> futures = new ArrayList<>();
        
        for (Path file : textFiles) {
            // Submit index task for each file
            futures.add(executor.submit(() -> {
                try {
                    indexFile(file);
                } catch (IOException e) {
                    System.err.println("Error indexing file " + file + ": " + e.getMessage());
                }
            }));
        }
        
        // Wait for all tasks to complete
        for (Future<?> future : futures) {
            try {
                future.get();
            } catch (ExecutionException e) {
                e.printStackTrace();
            }
        }
        
        executor.shutdown();
        System.out.println("Completed! Indexed " + index.size() + " keywords.");
    }
    
    private void indexFile(Path file) throws IOException {
        System.out.println("Indexing file: " + file.getFileName());
        
        String fileContent = Files.readString(file);
        String fileName = file.getFileName().toString();
        
        // Split content into words and process
        String[] words = fileContent.toLowerCase()
                       .replaceAll("[^a-z0-9\\s]", " ")
                       .split("\\s+");
        
        // Add each word to index
        Arrays.stream(words)
            .filter(word -> word.length() > 2) // Ignore short words
            .forEach(word -> {
                // putIfAbsent ensures atomic, then we update the set
                index.computeIfAbsent(word, k -> ConcurrentHashMap.newKeySet())
                     .add(fileName);
            });
    }
    
    public Set<String> search(String keyword) {
        String normalizedKeyword = keyword.toLowerCase().trim();
        Set<String> result = index.getOrDefault(normalizedKeyword, Collections.emptySet());
        return new HashSet<>(result); // Return copy to avoid direct modification
    }
    
    public void searchMultipleKeywords(String[] keywords) {
        System.out.println("\nSearch Results:");
        
        Arrays.stream(keywords)
            .map(String::toLowerCase)
            .forEach(keyword -> {
                Set<String> documents = search(keyword);
                
                System.out.println("\"" + keyword + "\" appears in " + 
                                  documents.size() + " documents:");
                
                documents.forEach(doc -> System.out.println("  - " + doc));
            });
    }
    
    public static void main(String[] args) {
        try {
            // Path to directory containing documents to index
            String documentsPath = "documents";
            
            // Create directory if not exists
            Files.createDirectories(Paths.get(documentsPath));
            
            // Create some sample text files for testing
            createSampleDocuments(documentsPath);
            
            // Initialize and run indexer
            ParallelDocumentIndexer indexer = new ParallelDocumentIndexer(documentsPath);
            indexer.buildIndex();
            
            // Search for some keywords
            String[] searchTerms = {"java", "programming", "concurrent", "concurrency", "thread"};
            indexer.searchMultipleKeywords(searchTerms);
            
        } catch (IOException | InterruptedException e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Create sample documents for testing
    private static void createSampleDocuments(String documentsPath) throws IOException {
        Map<String, String> sampleDocs = new HashMap<>();
        
        sampleDocs.put("java_basics.txt", 
            "Java is a popular object-oriented programming language. " +
            "It is designed to have as few implementation dependencies as possible. " +
            "Java applications are typically compiled to bytecode.");
            
        sampleDocs.put("concurrency_intro.txt",
            "Concurrency in Java allows executing multiple threads simultaneously. " +
            "This helps maximize resources of modern multi-core computers.");
            
        sampleDocs.put("threading_models.txt",
            "Java supports multithreading through Thread class and Runnable interface. " +
            "Since Java 5, concurrency API (java.util.concurrent) was introduced with many powerful features.");
            
        sampleDocs.put("memory_model.txt",
            "Java memory model specifies how threads interact through memory. " +
            "It defines rules to ensure values are read consistently across different threads.");
            
        sampleDocs.put("performance_tips.txt",
            "When programming multithreading in Java, need to avoid race conditions and deadlocks. " +
            "Using thread pool instead of creating threads directly will help improve application performance.");
        
        // Write sample files
        for (Map.Entry<String, String> entry : sampleDocs.entrySet()) {
            Path filePath = Paths.get(documentsPath, entry.getKey());
            Files.writeString(filePath, entry.getValue());
            System.out.println("Created sample file: " + filePath);
        }
    }
}
```

With knowledge of concurrent programming in Java, you can build efficient applications, make good use of hardware resources, and achieve higher performance compared to traditional sequential programming.


## 🧑‍🏫 Lesson 4: Database Connection with JDBC

### Loading Driver and Creating Connection

```java
// Load driver (only need to do once)
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    // Or with SQLite: Class.forName("org.sqlite.JDBC");
} catch (ClassNotFoundException e) {
    System.out.println("JDBC Driver not found");
    e.printStackTrace();
}

// Create connection
String url = "jdbc:mysql://localhost:3306/mydatabase";
String username = "root";
String password = "password";

try (Connection connection = DriverManager.getConnection(url, username, password)) {
    System.out.println("Connected to database successfully!");
    // Database operations
} catch (SQLException e) {
    System.out.println("Connection failed!");
    e.printStackTrace();
}
```

### Using Statement to Execute Queries

```java
public static void executeSimpleQuery(Connection conn) throws SQLException {
    // Create Statement
    try (Statement stmt = conn.createStatement()) {
        // Execute SQL query
        String sql = "SELECT id, name, email FROM users";
        ResultSet rs = stmt.executeQuery(sql);

        // Process results
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String email = rs.getString("email");

            System.out.println("ID: " + id + ", Name: " + name + ", Email: " + email);
        }
    }
}
```

### Using PreparedStatement for Safe Queries

```java
public static void findUserById(Connection conn, int userId) throws SQLException {
    String sql = "SELECT id, name, email FROM users WHERE id = ?";

    // Create PreparedStatement
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        // Set parameter
        pstmt.setInt(1, userId);

        // Execute query
        ResultSet rs = pstmt.executeQuery();

        // Process results
        if (rs.next()) {
            String name = rs.getString("name");
            String email = rs.getString("email");

            System.out.println("User found:");
            System.out.println("ID: " + userId + ", Name: " + name + ", Email: " + email);
        } else {
            System.out.println("User not found with ID: " + userId);
        }
    }
}
```

### Using try-with-resources with JDBC

```java
public static void safeDatabaseOperation() {
    String url = "jdbc:mysql://localhost:3306/mydatabase";
    String username = "root";
    String password = "password";

    // try-with-resources automatically closes Connection, Statement and ResultSet
    try (
        Connection conn = DriverManager.getConnection(url, username, password);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS user_count FROM users")
    ) {
        if (rs.next()) {
            int count = rs.getInt("user_count");
            System.out.println("Total users: " + count);
        }
    } catch (SQLException e) {
        System.out.println("Database operation error:");
        e.printStackTrace();
    }
}
```

### Real-world Example - Connection and Query

```java
import java.sql.*;

public class JDBCExample {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/library_db";
        String username = "root";
        String password = "password";

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            System.out.println("Connected to database successfully!");

            // Find all books published after 2020
            findBooksByYear(conn, 2020);

            // Find books by author
            findBooksByAuthor(conn, "J.K. Rowling");

        } catch (SQLException e) {
            System.out.println("Connection error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void findBooksByYear(Connection conn, int year) throws SQLException {
        String sql = "SELECT id, title, author, published_year FROM books WHERE published_year > ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, year);
            ResultSet rs = pstmt.executeQuery();

            System.out.println("\nBooks published after " + year + ":");
            while (rs.next()) {
                System.out.printf("ID: %d, Title: %s, Author: %s, Year: %d\n",
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("author"),
                    rs.getInt("published_year"));
            }
        }
    }

    public static void findBooksByAuthor(Connection conn, String authorName) throws SQLException {
        String sql = "SELECT id, title, published_year FROM books WHERE author LIKE ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + authorName + "%");  // Fuzzy search
            ResultSet rs = pstmt.executeQuery();

            System.out.println("\nBooks by author '" + authorName + "':");
            boolean found = false;

            while (rs.next()) {
                found = true;
                System.out.printf("ID: %d, Title: %s, Published Year: %d\n",
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getInt("published_year"));
            }

            if (!found) {
                System.out.println("No books found for this author.");
            }
        }
    }
}
```

## 🧑‍🏫 Lesson 5: CRUD Operations with JDBC

### Creating Table in Database

```java
public static void createTable(Connection conn) throws SQLException {
    String sql = "CREATE TABLE IF NOT EXISTS students (" +
                "id INT AUTO_INCREMENT PRIMARY KEY," +
                "name VARCHAR(100) NOT NULL," +
                "email VARCHAR(100) UNIQUE," +
                "age INT," +
                "gpa DOUBLE" +
                ")";

    try (Statement stmt = conn.createStatement()) {
        stmt.execute(sql);
        System.out.println("Table 'students' created or already exists");
    }
}
```

### Adding Data (Create)

```java
public static void addStudent(Connection conn, String name, String email, int age, double gpa)
        throws SQLException {
    String sql = "INSERT INTO students (name, email, age, gpa) VALUES (?, ?, ?, ?)";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setInt(3, age);
        pstmt.setDouble(4, gpa);

        int rowsInserted = pstmt.executeUpdate();
        if (rowsInserted > 0) {
            System.out.println("Successfully added student: " + name);
        }
    }
}
```

### Querying Data (Read)

```java
public static void getAllStudents(Connection conn) throws SQLException {
    String sql = "SELECT id, name, email, age, gpa FROM students";

    try (Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {

        if (!rs.isBeforeFirst()) {
            System.out.println("No students in database");
            return;
        }

        System.out.println("\n----- STUDENT LIST -----");
        System.out.printf("%-5s %-20s %-25s %-5s %-5s\n",
                        "ID", "Name", "Email", "Age", "GPA");
        System.out.println("-----------------------------------------------------------");

        while (rs.next()) {
            System.out.printf("%-5d %-20s %-25s %-5d %-5.2f\n",
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getInt("age"),
                            rs.getDouble("gpa"));
        }
    }
}

public static void findStudentByName(Connection conn, String searchName) throws SQLException {
    String sql = "SELECT id, name, email, age, gpa FROM students WHERE name LIKE ?";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, "%" + searchName + "%");

        try (ResultSet rs = pstmt.executeQuery()) {
            boolean found = false;

            System.out.println("\n----- SEARCH STUDENT -----");
            System.out.printf("%-5s %-20s %-25s %-5s %-5s\n",
                            "ID", "Name", "Email", "Age", "GPA");
            System.out.println("-----------------------------------------------------------");

            while (rs.next()) {
                found = true;
                System.out.printf("%-5d %-20s %-25s %-5d %-5.2f\n",
                                rs.getInt("id"),
                                rs.getString("name"),
                                rs.getString("email"),
                                rs.getInt("age"),
                                rs.getDouble("gpa"));
            }

            if (!found) {
                System.out.println("No student found with name \"" + searchName + "\"");
            }
        }
    }
}
```

### Updating Data (Update)

```java
public static void updateStudentGPA(Connection conn, int studentId, double newGPA)
        throws SQLException {
    String sql = "UPDATE students SET gpa = ? WHERE id = ?";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setDouble(1, newGPA);
        pstmt.setInt(2, studentId);

        int rowsUpdated = pstmt.executeUpdate();
        if (rowsUpdated > 0) {
            System.out.println("Updated GPA for student ID = " + studentId);
        } else {
            System.out.println("Student not found with ID = " + studentId);
        }
    }
}
```

### Deleting Data (Delete)

```java
public static void deleteStudent(Connection conn, int studentId) throws SQLException {
    // First, check if student exists
    String checkSql = "SELECT name FROM students WHERE id = ?";
    try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
        checkStmt.setInt(1, studentId);

        try (ResultSet rs = checkStmt.executeQuery()) {
            if (rs.next()) {
                String studentName = rs.getString("name");

                // Student exists, proceed to delete
                String deleteSql = "DELETE FROM students WHERE id = ?";
                try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                    deleteStmt.setInt(1, studentId);

                    int rowsDeleted = deleteStmt.executeUpdate();
                    System.out.println("Deleted student: " + studentName);
                }
            } else {
                System.out.println("Student not found with ID = " + studentId);
            }
        }
    }
}
```

### Real-world Example - Complete CRUD Student Management

```java
import java.sql.*;
import java.util.Scanner;

public class StudentManagementSystem {
    // Database connection info
    private static final String URL = "jdbc:mysql://localhost:3306/school_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "password";

    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        try {
            // Load driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create connection
            try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
                // Create table if not exists
                createTable(conn);

                boolean running = true;
                while (running) {
                    displayMenu();
                    int choice = scanner.nextInt();
                    scanner.nextLine(); // Read newline

                    switch (choice) {
                        case 1:
                            addNewStudent(conn);
                            break;
                        case 2:
                            viewAllStudents(conn);
                            break;
                        case 3:
                            searchStudent(conn);
                            break;
                        case 4:
                            updateStudent(conn);
                            break;
                        case 5:
                            deleteStudentRecord(conn);
                            break;
                        case 0:
                            running = false;
                            System.out.println("Thank you for using the program!");
                            break;
                        default:
                            System.out.println("Invalid choice!");
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void displayMenu() {
        System.out.println("\n----- STUDENT MANAGEMENT SYSTEM -----");
        System.out.println("1. Add new student");
        System.out.println("2. View all students");
        System.out.println("3. Search student by name");
        System.out.println("4. Update student GPA");
        System.out.println("5. Delete student");
        System.out.println("0. Exit");
        System.out.print("Select function: ");
    }

    private static void addNewStudent(Connection conn) throws SQLException {
        System.out.println("\n----- ADD NEW STUDENT -----");

        System.out.print("Enter student name: ");
        String name = scanner.nextLine();

        System.out.print("Enter email: ");
        String email = scanner.nextLine();

        System.out.print("Enter age: ");
        int age = scanner.nextInt();

        System.out.print("Enter GPA: ");
        double gpa = scanner.nextDouble();
        scanner.nextLine(); // Read newline

        addStudent(conn, name, email, age, gpa);
    }

    private static void viewAllStudents(Connection conn) throws SQLException {
        getAllStudents(conn);
    }

    private static void searchStudent(Connection conn) throws SQLException {
        System.out.print("\nEnter student name to search: ");
        String searchName = scanner.nextLine();

        findStudentByName(conn, searchName);
    }

    private static void updateStudent(Connection conn) throws SQLException {
        System.out.print("\nEnter student ID to update: ");
        int id = scanner.nextInt();

        System.out.print("Enter new GPA: ");
        double newGPA = scanner.nextDouble();
        scanner.nextLine(); // Read newline

        updateStudentGPA(conn, id, newGPA);
    }

    private static void deleteStudentRecord(Connection conn) throws SQLException {
        System.out.print("\nEnter student ID to delete: ");
        int id = scanner.nextInt();
        scanner.nextLine(); // Read newline

        System.out.print("Are you sure you want to delete this student? (y/n): ");
        String confirm = scanner.nextLine();

        if (confirm.equalsIgnoreCase("y")) {
            deleteStudent(conn, id);
        } else {
            System.out.println("Delete operation cancelled");
        }
    }

    // Other CRUD methods defined above...
}
```

### Error Handling and Transactions

```java
public static void registerStudentWithCourses(Connection conn, String studentName,
                                            String email, int[] courseIds) throws SQLException {
    // Disable auto-commit to use transaction
    boolean autoCommit = conn.getAutoCommit();
    conn.setAutoCommit(false);

    try {
        // 1. Add new student
        String insertStudentSql = "INSERT INTO students (name, email) VALUES (?, ?)";
        int studentId;

        try (PreparedStatement pstmt = conn.prepareStatement(insertStudentSql,
                                                        Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, studentName);
            pstmt.setString(2, email);
            pstmt.executeUpdate();

            // Get ID of newly added student
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    studentId = rs.getInt(1);
                } else {
                    throw new SQLException("Cannot get ID of newly added student");
                }
            }
        }

        // 2. Register student for courses
        String registerCourseSql = "INSERT INTO student_courses (student_id, course_id) VALUES (?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(registerCourseSql)) {
            for (int courseId : courseIds) {
                pstmt.setInt(1, studentId);
                pstmt.setInt(2, courseId);
                pstmt.executeUpdate();
            }
        }

        // If everything OK, commit transaction
        conn.commit();
        System.out.println("Registered student " + studentName + " with " +
                            courseIds.length + " courses");

    } catch (SQLException e) {
        // If error, rollback
        try {
            System.out.println("Transaction failed, rolling back...");
            conn.rollback();
        } catch (SQLException ex) {
            System.out.println("Error rolling back: " + ex.getMessage());
        }
        throw e;
    } finally {
        // Restore auto-commit state
        conn.setAutoCommit(autoCommit);
    }
}
```

## 🧑‍🏫 Lesson 6: Practice - Building Application with JDBC

### Simple Database Design

```sql
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(10) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INT
);

CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade DOUBLE,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    UNIQUE (student_id, course_id)
);
```

### Database Connection Class

```java
public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/school_management";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "password";

    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            } catch (ClassNotFoundException e) {
                throw new SQLException("JDBC Driver not found", e);
            }
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
```

### Student DAO (Data Access Object) Class

```java
public class StudentDAO {
    private Connection conn;

    public StudentDAO() throws SQLException {
        this.conn = DatabaseConnection.getConnection();
    }

    // Add new student
    public boolean addStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (student_id, name, birth_date, email, phone) " +
                    "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getStudentId());
            pstmt.setString(2, student.getName());
            pstmt.setDate(3, new java.sql.Date(student.getBirthDate().getTime()));
            pstmt.setString(4, student.getEmail());
            pstmt.setString(5, student.getPhone());

            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        }
    }

    // Get all students
    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT id, student_id, name, birth_date, email, phone FROM students";

        try (Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setStudentId(rs.getString("student_id"));
                student.setName(rs.getString("name"));
                student.setBirthDate(rs.getDate("birth_date"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));

                students.add(student);
            }
        }

        return students;
    }

    // Find student by ID
    public Student findByStudentId(String studentId) throws SQLException {
        String sql = "SELECT id, student_id, name, birth_date, email, phone " +
                    "FROM students WHERE student_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setStudentId(rs.getString("student_id"));
                    student.setName(rs.getString("name"));
                    student.setBirthDate(rs.getDate("birth_date"));
                    student.setEmail(rs.getString("email"));
                    student.setPhone(rs.getString("phone"));

                    return student;
                }
            }
        }

        return null; // Not found
    }

    // Update student info
    public boolean updateStudent(Student student) throws SQLException {
        String sql = "UPDATE students SET name = ?, birth_date = ?, email = ?, phone = ? " +
                    "WHERE student_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, student.getName());
            pstmt.setDate(2, new java.sql.Date(student.getBirthDate().getTime()));
            pstmt.setString(3, student.getEmail());
            pstmt.setString(4, student.getPhone());
            pstmt.setString(5, student.getStudentId());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    // Delete student
    public boolean deleteStudent(String studentId) throws SQLException {
        String sql = "DELETE FROM students WHERE student_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, studentId);

            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }
}
```

### Student Class

```java
import java.util.Date;

public class Student {
    private int id;
    private String studentId;  // Student ID code
    private String name;
    private Date birthDate;
    private String email;
    private String phone;

    // Default constructor
    public Student() {
    }

    // Parameterized constructor
    public Student(String studentId, String name, Date birthDate, String email, String phone) {
        this.studentId = studentId;
        this.name = name;
        this.birthDate = birthDate;
        this.email = email;
        this.phone = phone;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Student [id=" + id + ", studentId=" + studentId + ", name=" + name +
                ", birthDate=" + birthDate + ", email=" + email + ", phone=" + phone + "]";
    }
}
```

### Complete Application with Multithreading

```java
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class StudentManagementApp {
    private static Scanner scanner = new Scanner(System.in);
    private static StudentDAO studentDAO;
    private static ExecutorService executor = Executors.newFixedThreadPool(3);
    private static SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

    public static void main(String[] args) {
        try {
            // Initialize DAO
            studentDAO = new StudentDAO();

            boolean running = true;
            while (running) {
                displayMenu();
                int choice = scanner.nextInt();
                scanner.nextLine(); // Read newline

                switch (choice) {
                    case 1:
                        addNewStudent();
                        break;
                    case 2:
                        displayAllStudents();
                        break;
                    case 3:
                        findStudentById();
                        break;
                    case 4:
                        updateStudentInfo();
                        break;
                    case 5:
                        deleteStudentRecord();
                        break;
                    case 6:
                        backupDataToFile();
                        break;
                    case 0:
                        running = false;
                        executor.shutdown();
                        DatabaseConnection.closeConnection();
                        System.out.println("Thank you for using the program!");
                        break;
                    default:
                        System.out.println("Invalid choice!");
                }
            }
        } catch (SQLException e) {
            System.out.println("Database connection error: " + e.getMessage());
        } finally {
            if (executor != null && !executor.isShutdown()) {
                executor.shutdown();
            }
        }
    }

    private static void displayMenu() {
        System.out.println("\n=== STUDENT MANAGEMENT SYSTEM ===");
        System.out.println("1. Add new student");
        System.out.println("2. View all students");
        System.out.println("3. Find student by ID");
        System.out.println("4. Update student info");
        System.out.println("5. Delete student");
        System.out.println("6. Backup data to file");
        System.out.println("0. Exit");
        System.out.print("Select function: ");
    }

    private static void addNewStudent() {
        System.out.println("\n=== ADD NEW STUDENT ===");

        try {
            System.out.print("Enter student ID: ");
            String studentId = scanner.nextLine();

            System.out.print("Enter name: ");
            String name = scanner.nextLine();

            System.out.print("Enter birth date (dd/MM/yyyy): ");
            String birthDateStr = scanner.nextLine();
            Date birthDate = dateFormat.parse(birthDateStr);

            System.out.print("Enter email: ");
            String email = scanner.nextLine();

            System.out.print("Enter phone number: ");
            String phone = scanner.nextLine();

            Student student = new Student(studentId, name, birthDate, email, phone);

            // Execute adding student in separate thread
            executor.submit(() -> {
                try {
                    boolean success = studentDAO.addStudent(student);
                    if (success) {
                        System.out.println("Student added successfully!");
                    } else {
                        System.out.println("Failed to add student!");
                    }
                } catch (SQLException e) {
                    System.out.println("Error: " + e.getMessage());
                }
            });

        } catch (ParseException e) {
            System.out.println("Invalid date format. Please use dd/MM/yyyy");
        }
    }

    private static void displayAllStudents() {
        System.out.println("\n=== STUDENT LIST ===");

        executor.submit(() -> {
            try {
                List<Student> students = studentDAO.getAllStudents();

                if (students.isEmpty()) {
                    System.out.println("No students in database");
                    return;
                }

                System.out.printf("%-10s %-30s %-15s %-25s %-15s\n",
                               "ID", "Full Name", "Birth Date", "Email", "Phone");
                System.out.println("--------------------------------------------------------------------------------------------------------");

                for (Student student : students) {
                    System.out.printf("%-10s %-30s %-15s %-25s %-15s\n",
                                   student.getStudentId(),
                                   student.getName(),
                                   dateFormat.format(student.getBirthDate()),
                                   student.getEmail(),
                                   student.getPhone());
                }
            } catch (SQLException e) {
                System.out.println("Error retrieving student list: " + e.getMessage());
            }
        });
    }

    private static void findStudentById() {
        System.out.print("\nEnter student ID to find: ");
        String studentId = scanner.nextLine();

        executor.submit(() -> {
            try {
                Student student = studentDAO.findByStudentId(studentId);

                if (student != null) {
                    System.out.println("\n=== STUDENT INFO ===");
                    System.out.println("Student ID: " + student.getStudentId());
                    System.out.println("Full Name: " + student.getName());
                    System.out.println("Birth Date: " + dateFormat.format(student.getBirthDate()));
                    System.out.println("Email: " + student.getEmail());
                    System.out.println("Phone: " + student.getPhone());
                } else {
                    System.out.println("Student not found with ID " + studentId);
                }
            } catch (SQLException e) {
                System.out.println("Error finding student: " + e.getMessage());
            }
        });
    }

    private static void updateStudentInfo() {
        System.out.print("\nEnter student ID to update: ");
        String studentId = scanner.nextLine();

        executor.submit(() -> {
            try {
                Student student = studentDAO.findByStudentId(studentId);

                if (student != null) {
                    System.out.println("\n=== UPDATE STUDENT INFO ===");
                    System.out.println("Current student: " + student.getName());

                    System.out.print("Enter new name (Enter to keep): ");
                    String name = scanner.nextLine();
                    if (!name.isEmpty()) {
                        student.setName(name);
                    }

                    System.out.print("Enter new birth date (dd/MM/yyyy) (Enter to keep): ");
                    String birthDateStr = scanner.nextLine();
                    if (!birthDateStr.isEmpty()) {
                        try {
                            Date birthDate = dateFormat.parse(birthDateStr);
                            student.setBirthDate(birthDate);
                        } catch (ParseException e) {
                            System.out.println("Invalid date format, keeping old birth date");
                        }
                    }

                    System.out.print("Enter new email (Enter to keep): ");
                    String email = scanner.nextLine();
                    if (!email.isEmpty()) {
                        student.setEmail(email);
                    }

                    System.out.print("Enter new phone (Enter to keep): ");
                    String phone = scanner.nextLine();
                    if (!phone.isEmpty()) {
                        student.setPhone(phone);
                    }

                    boolean success = studentDAO.updateStudent(student);
                    if (success) {
                        System.out.println("Student info updated successfully!");
                    } else {
                        System.out.println("Failed to update student info!");
                    }
                } else {
                    System.out.println("Student not found with ID " + studentId);
                }
            } catch (SQLException e) {
                System.out.println("Error updating student info: " + e.getMessage());
            }
        });
    }

    private static void deleteStudentRecord() {
        System.out.print("\nEnter student ID to delete: ");
        String studentId = scanner.nextLine();

        System.out.print("Are you sure you want to delete this student? (y/n): ");
        String confirm = scanner.nextLine();

        if (confirm.equalsIgnoreCase("y")) {
            executor.submit(() -> {
                try {
                    boolean success = studentDAO.deleteStudent(studentId);
                    if (success) {
                        System.out.println("Student deleted successfully!");
                    } else {
                        System.out.println("Student not found with ID " + studentId);
                    }
                } catch (SQLException e) {
                    System.out.println("Error deleting student: " + e.getMessage());
                }
            });
        } else {
            System.out.println("Delete operation cancelled");
        }
    }

    private static void backupDataToFile() {
        System.out.println("\n=== BACKUP DATA ===");
        System.out.print("Enter file path to save: ");
        String filePath = scanner.nextLine();

        executor.submit(() -> {
            try {
                List<Student> students = studentDAO.getAllStudents();

                // Create another thread to write file
                Runnable backupTask = () -> {
                    try (java.io.PrintWriter writer = new java.io.PrintWriter(new java.io.FileWriter(filePath))) {
                        writer.println("Student ID,Full Name,Birth Date,Email,Phone");

                        for (Student student : students) {
                            writer.printf("%s,%s,%s,%s,%s\n",
                                       student.getStudentId(),
                                       student.getName(),
                                       dateFormat.format(student.getBirthDate()),
                                       student.getEmail(),
                                       student.getPhone());
                        }

                        System.out.println("Data backed up successfully to file: " + filePath);
                    } catch (java.io.IOException e) {
                        System.out.println("Error writing file: " + e.getMessage());
                    }
                };

                // Use executor to perform backup task
                executor.submit(backupTask);

            } catch (SQLException e) {
                System.out.println("Error retrieving data for backup: " + e.getMessage());
            }
        });
    }
}
```

## 🧪 FINAL PROJECT: Student Management System with Database

### Project Description

Build a JAVA application with the following functions:

- Connect to a database (MySQL or SQLite).
- Allow:
  - Add student (ID, name, birth date, email).
  - View student list.
  - Edit, delete student.
  - Find student by name or ID.
- Command line interface, menu options.

### Requirements

- Use JDBC to manipulate data.
- Handle multithreading when reading/writing backup files in parallel with user operations.
- Ensure data is not conflicted when there are multiple concurrent operations.

Here, we will temporarily pause the journey with JAVA to enter the world of SQL - the most widely used database query language today. This will not only expand your knowledge but also help you understand deeper how applications interact with databases - an essential skill in most real-world software development projects.
