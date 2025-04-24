# 📘 PHẦN 5: LUỒNG, ĐA LUỒNG VÀ JDBC

- [📘 PHẦN 5: LUỒNG, ĐA LUỒNG VÀ JDBC](#-phần-5-luồng-đa-luồng-và-jdbc)
  - [🎯 Mục tiêu tổng quát](#-mục-tiêu-tổng-quát)
  - [🧑‍🏫 Bài 1: JAVA I/O Streams](#-bài-1-java-io-streams)
    - [Khái niệm luồng (Streams) trong Java](#khái-niệm-luồng-streams-trong-java)
      - [Phân loại cơ bản](#phân-loại-cơ-bản)
    - [Các lớp thường sử dụng](#các-lớp-thường-sử-dụng)
      - [Luồng byte](#luồng-byte)
      - [Luồng ký tự](#luồng-ký-tự)
    - [Đọc file với InputStream và Reader](#đọc-file-với-inputstream-và-reader)
      - [Đọc file nhị phân với FileInputStream](#đọc-file-nhị-phân-với-fileinputstream)
      - [Đọc file văn bản với BufferedReader](#đọc-file-văn-bản-với-bufferedreader)
    - [Ghi file với OutputStream và Writer](#ghi-file-với-outputstream-và-writer)
      - [Ghi file nhị phân với FileOutputStream](#ghi-file-nhị-phân-với-fileoutputstream)
      - [Ghi file văn bản với BufferedWriter](#ghi-file-văn-bản-với-bufferedwriter)
    - [Ứng dụng thực tế: Sao chép file với buffer](#ứng-dụng-thực-tế-sao-chép-file-với-buffer)
    - [Serialization và Deserialization](#serialization-và-deserialization)
    - [Xử lý với các loại encoding khác nhau](#xử-lý-với-các-loại-encoding-khác-nhau)
    - [Thực hành: Tạo ứng dụng ghi nhật ký (Logger)](#thực-hành-tạo-ứng-dụng-ghi-nhật-ký-logger)
  - [🧑‍🏫 Bài 2: Đa luồng trong JAVA](#-bài-2-đa-luồng-trong-java)
    - [Khái niệm Thread và lợi ích của đa luồng](#khái-niệm-thread-và-lợi-ích-của-đa-luồng)
      - [Lợi ích của đa luồng](#lợi-ích-của-đa-luồng)
    - [Tạo Thread trong Java](#tạo-thread-trong-java)
      - [1. Kế thừa lớp Thread](#1-kế-thừa-lớp-thread)
      - [2. Triển khai giao diện Runnable](#2-triển-khai-giao-diện-runnable)
      - [3. Sử dụng biểu thức lambda (Java 8+)](#3-sử-dụng-biểu-thức-lambda-java-8)
    - [Quản lý luồng](#quản-lý-luồng)
      - [Bắt đầu luồng (start)](#bắt-đầu-luồng-start)
      - [Chờ luồng kết thúc (join)](#chờ-luồng-kết-thúc-join)
      - [Tạm dừng luồng (sleep)](#tạm-dừng-luồng-sleep)
      - [Ngắt một luồng (interrupt)](#ngắt-một-luồng-interrupt)
      - [Ưu tiên luồng (priority)](#ưu-tiên-luồng-priority)
    - [Đồng bộ hóa (Synchronization)](#đồng-bộ-hóa-synchronization)
      - [Vấn đề race condition](#vấn-đề-race-condition)
      - [Đồng bộ hóa bằng từ khóa synchronized](#đồng-bộ-hóa-bằng-từ-khóa-synchronized)
      - [Ví dụ thực tế: Đồng bộ hóa truy cập tập tin](#ví-dụ-thực-tế-đồng-bộ-hóa-truy-cập-tập-tin)
    - [Các vấn đề trong lập trình đa luồng](#các-vấn-đề-trong-lập-trình-đa-luồng)
      - [Deadlock (Bế tắc)](#deadlock-bế-tắc)
      - [Tránh Deadlock](#tránh-deadlock)
    - [Ví dụ thực tế: Mô phỏng nhà hàng](#ví-dụ-thực-tế-mô-phỏng-nhà-hàng)
    - [Thực hành: Tạo chương trình tải file song song](#thực-hành-tạo-chương-trình-tải-file-song-song)
  - [🧑‍🏫 Bài 3: Lập trình đồng thời (Concurrency)](#-bài-3-lập-trình-đồng-thời-concurrency)
    - [Concurrency API trong Java](#concurrency-api-trong-java)
      - [ExecutorService và Thread Pool](#executorservice-và-thread-pool)
      - [Các loại Executor phổ biến](#các-loại-executor-phổ-biến)
    - [Callable và Future](#callable-và-future)
    - [CompletableFuture trong Java 8+](#completablefuture-trong-java-8)
    - [Đồng bộ hóa nâng cao với Lock Interface](#đồng-bộ-hóa-nâng-cao-với-lock-interface)
    - [Semaphore và Latch](#semaphore-và-latch)
    - [Biến nguyên tử (Atomic Variables)](#biến-nguyên-tử-atomic-variables)
    - [ConcurrentHashMap và CopyOnWriteArrayList](#concurrenthashmap-và-copyonwritearraylist)
    - [Ví dụ thực tế: Xử lý dữ liệu song song](#ví-dụ-thực-tế-xử-lý-dữ-liệu-song-song)
    - [Phương pháp hay nhất (Best Practices)](#phương-pháp-hay-nhất-best-practices)
    - [Bài tập thực hành: Xây dựng hệ thống Index tài liệu song song](#bài-tập-thực-hành-xây-dựng-hệ-thống-index-tài-liệu-song-song)
  - [🧑‍🏫 Bài 4: Kết nối cơ sở dữ liệu với JDBC](#-bài-4-kết-nối-cơ-sở-dữ-liệu-với-jdbc)
    - [Tải Driver và tạo kết nối](#tải-driver-và-tạo-kết-nối)
    - [Sử dụng Statement để thực thi truy vấn](#sử-dụng-statement-để-thực-thi-truy-vấn)
    - [Sử dụng PreparedStatement để thực thi truy vấn an toàn](#sử-dụng-preparedstatement-để-thực-thi-truy-vấn-an-toàn)
    - [Sử dụng try-with-resources với JDBC](#sử-dụng-try-with-resources-với-jdbc)
    - [Ví dụ thực tế - Kết nối và truy vấn cơ sở dữ liệu](#ví-dụ-thực-tế---kết-nối-và-truy-vấn-cơ-sở-dữ-liệu)
  - [🧑‍🏫 Bài 5: Thao tác CRUD với JDBC](#-bài-5-thao-tác-crud-với-jdbc)
    - [Tạo bảng trong cơ sở dữ liệu](#tạo-bảng-trong-cơ-sở-dữ-liệu)
    - [Thêm dữ liệu (Create)](#thêm-dữ-liệu-create)
    - [Truy vấn dữ liệu (Read)](#truy-vấn-dữ-liệu-read)
    - [Cập nhật dữ liệu (Update)](#cập-nhật-dữ-liệu-update)
    - [Xóa dữ liệu (Delete)](#xóa-dữ-liệu-delete)
    - [Ví dụ thực tế - Quản lý sinh viên CRUD hoàn chỉnh](#ví-dụ-thực-tế---quản-lý-sinh-viên-crud-hoàn-chỉnh)
    - [Xử lý lỗi và Transaction](#xử-lý-lỗi-và-transaction)
  - [🧑‍🏫 Bài 6: Thực hành viết ứng dụng với JDBC](#-bài-6-thực-hành-viết-ứng-dụng-với-jdbc)
    - [Thiết kế cơ sở dữ liệu đơn giản](#thiết-kế-cơ-sở-dữ-liệu-đơn-giản)
    - [Lớp kết nối cơ sở dữ liệu](#lớp-kết-nối-cơ-sở-dữ-liệu)
    - [Lớp DAO (Data Access Object) cho Student](#lớp-dao-data-access-object-cho-student)
    - [Lớp Student](#lớp-student)
    - [Ứng dụng hoàn chỉnh với đa luồng](#ứng-dụng-hoàn-chỉnh-với-đa-luồng)
  - [🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý sinh viên với cơ sở dữ liệu](#-bài-tập-lớn-cuối-phần-hệ-thống-quản-lý-sinh-viên-với-cơ-sở-dữ-liệu)
    - [Mô tả bài tập](#mô-tả-bài-tập)
    - [Yêu cầu](#yêu-cầu)

## 🎯 Mục tiêu tổng quát

- Hiểu cách xử lý nhập/xuất dữ liệu bằng luồng (Streams).
- Làm quen với lập trình đa luồng (Multithreading).
- Kết nối và thao tác dữ liệu với cơ sở dữ liệu sử dụng JDBC.

---

## 🧑‍🏫 Bài 1: JAVA I/O Streams

### Khái niệm luồng (Streams) trong Java

Luồng là một chuỗi dữ liệu liên tục, được đọc từ nguồn (source) hoặc ghi vào đích (destination). Trong Java, luồng được quản lý thông qua các lớp trong gói `java.io`.

#### Phân loại cơ bản

1. **Luồng byte (Byte Streams)**: Xử lý dữ liệu dạng byte (8-bit).
   - Lớp cơ sở: `InputStream` và `OutputStream`
   - Thích hợp cho dữ liệu nhị phân như hình ảnh, âm thanh, video

2. **Luồng ký tự (Character Streams)**: Xử lý dữ liệu dạng ký tự (Unicode).
   - Lớp cơ sở: `Reader` và `Writer`
   - Thích hợp cho văn bản, tập tin cấu hình

### Các lớp thường sử dụng

#### Luồng byte

- `FileInputStream`/`FileOutputStream`: Đọc/ghi dữ liệu từ/vào tập tin
- `BufferedInputStream`/`BufferedOutputStream`: Tối ưu hiệu suất bằng buffer
- `DataInputStream`/`DataOutputStream`: Đọc/ghi các kiểu dữ liệu nguyên thủy
- `ObjectInputStream`/`ObjectOutputStream`: Đọc/ghi đối tượng (Serialization)

#### Luồng ký tự

- `FileReader`/`FileWriter`: Đọc/ghi văn bản từ/vào tập tin
- `BufferedReader`/`BufferedWriter`: Tối ưu hiệu suất cho luồng ký tự
- `InputStreamReader`/`OutputStreamWriter`: Chuyển đổi giữa byte và ký tự
- `PrintWriter`: Xuất dữ liệu dạng định dạng

### Đọc file với InputStream và Reader

#### Đọc file nhị phân với FileInputStream

```java
public static void readBinaryFile(String filePath) {
    try (FileInputStream fis = new FileInputStream(filePath)) {
        int data;
        System.out.println("Đọc dữ liệu nhị phân từ file: " + filePath);
        
        // Đọc từng byte cho đến khi hết file (-1)
        while ((data = fis.read()) != -1) {
            System.out.print(data + " ");
        }
    } catch (FileNotFoundException e) {
        System.err.println("Không tìm thấy file: " + e.getMessage());
    } catch (IOException e) {
        System.err.println("Lỗi khi đọc file: " + e.getMessage());
    }
}
```

#### Đọc file văn bản với BufferedReader

```java
public static void readTextFile(String filePath) {
    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        System.out.println("Đọc văn bản từ file: " + filePath);
        
        // Đọc từng dòng cho đến khi hết file (null)
        while ((line = reader.readLine()) != null) {
            System.out.println(line);
        }
    } catch (FileNotFoundException e) {
        System.err.println("Không tìm thấy file: " + e.getMessage());
    } catch (IOException e) {
        System.err.println("Lỗi khi đọc file: " + e.getMessage());
    }
}
```

### Ghi file với OutputStream và Writer

#### Ghi file nhị phân với FileOutputStream

```java
public static void writeBinaryFile(String filePath, byte[] data) {
    try (FileOutputStream fos = new FileOutputStream(filePath)) {
        fos.write(data);
        System.out.println("Đã ghi " + data.length + " byte vào file: " + filePath);
    } catch (FileNotFoundException e) {
        System.err.println("Không thể tạo file: " + e.getMessage());
    } catch (IOException e) {
        System.err.println("Lỗi khi ghi file: " + e.getMessage());
    }
}
```

#### Ghi file văn bản với BufferedWriter

```java
public static void writeTextFile(String filePath, List<String> lines) {
    try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
        for (String line : lines) {
            writer.write(line);
            writer.newLine(); // Thêm ký tự xuống dòng
        }
        System.out.println("Đã ghi " + lines.size() + " dòng vào file: " + filePath);
    } catch (IOException e) {
        System.err.println("Lỗi khi ghi file: " + e.getMessage());
    }
}
```

### Ứng dụng thực tế: Sao chép file với buffer

```java
public static void copyFile(String sourceFile, String destinationFile) {
    try (FileInputStream fis = new FileInputStream(sourceFile);
         BufferedInputStream bis = new BufferedInputStream(fis);
         FileOutputStream fos = new FileOutputStream(destinationFile);
         BufferedOutputStream bos = new BufferedOutputStream(fos)) {
        
        byte[] buffer = new byte[4096]; // Buffer 4KB
        int bytesRead;
        
        // Đọc và ghi theo từng khối buffer
        while ((bytesRead = bis.read(buffer)) != -1) {
            bos.write(buffer, 0, bytesRead);
        }
        
        System.out.println("Sao chép file thành công!");
        System.out.println("Từ: " + sourceFile);
        System.out.println("Đến: " + destinationFile);
        
    } catch (IOException e) {
        System.err.println("Lỗi khi sao chép file: " + e.getMessage());
    }
}
```

### Serialization và Deserialization

Serialization là quá trình chuyển đổi một đối tượng thành dãy byte để lưu trữ hoặc truyền đi:

```java
// Lớp Student phải implements Serializable
public static void serializeObject(String filePath, Student student) {
    try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filePath))) {
        oos.writeObject(student);
        System.out.println("Đã lưu đối tượng Student vào file: " + filePath);
    } catch (IOException e) {
        System.err.println("Lỗi khi lưu đối tượng: " + e.getMessage());
    }
}

public static Student deserializeObject(String filePath) {
    try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filePath))) {
        Student student = (Student) ois.readObject();
        System.out.println("Đã đọc đối tượng Student từ file: " + filePath);
        return student;
    } catch (IOException | ClassNotFoundException e) {
        System.err.println("Lỗi khi đọc đối tượng: " + e.getMessage());
        return null;
    }
}
```

### Xử lý với các loại encoding khác nhau

```java
public static void readFileWithEncoding(String filePath, String encoding) {
    try (BufferedReader reader = new BufferedReader(
            new InputStreamReader(new FileInputStream(filePath), encoding))) {
        
        String line;
        System.out.println("Đọc file với encoding " + encoding + ":");
        
        while ((line = reader.readLine()) != null) {
            System.out.println(line);
        }
    } catch (UnsupportedEncodingException e) {
        System.err.println("Encoding không được hỗ trợ: " + encoding);
    } catch (IOException e) {
        System.err.println("Lỗi khi đọc file: " + e.getMessage());
    }
}
```

### Thực hành: Tạo ứng dụng ghi nhật ký (Logger)

```java
public class SimpleLogger {
    private static final String LOG_FILE = "application.log";
    private static PrintWriter writer;
    
    static {
        try {
            // Tạo writer cho file log, chế độ append (true)
            writer = new PrintWriter(new BufferedWriter(new FileWriter(LOG_FILE, true)));
            
            // Thêm header khi khởi động
            writer.println("=== Log started at: " + new Date() + " ===");
            writer.flush();
        } catch (IOException e) {
            System.err.println("Không thể khởi tạo logger: " + e.getMessage());
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

---

## 🧑‍🏫 Bài 2: Đa luồng trong JAVA

### Khái niệm Thread và lợi ích của đa luồng

**Thread (luồng)** là đơn vị nhỏ nhất của quá trình xử lý có thể được lập lịch bởi hệ điều hành. Một chương trình Java chạy trong một quá trình (process) riêng, nhưng có thể có nhiều luồng thực thi đồng thời trong quá trình đó.

#### Lợi ích của đa luồng

1. **Tận dụng tài nguyên CPU**: Trên hệ thống đa nhân, nhiều luồng có thể chạy song song
2. **Tăng hiệu suất**: Thực hiện đồng thời nhiều tác vụ
3. **Cải thiện tính phản hồi**: Giữ giao diện người dùng phản hồi nhanh trong khi thực hiện các tác vụ nặng ở nền
4. **Tối ưu hóa thời gian chờ**: Trong khi một luồng đang chờ I/O, các luồng khác có thể tiếp tục thực thi

### Tạo Thread trong Java

Có hai cách chính để tạo thread trong Java:

#### 1. Kế thừa lớp Thread

```java
class MyThread extends Thread {
    @Override
    public void run() {
        // Mã lệnh sẽ được thực thi trong luồng mới
        for (int i = 1; i <= 5; i++) {
            System.out.println("Thread [" + getName() + "]: Số " + i);
            try {
                // Tạm dừng luồng trong 1 giây
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println("Thread bị gián đoạn");
                return;
            }
        }
        System.out.println("Thread [" + getName() + "] kết thúc.");
    }
}

// Sử dụng
public static void main(String[] args) {
    MyThread thread1 = new MyThread();
    thread1.setName("MyThread-1");
    thread1.start();  // Bắt đầu luồng mới, gọi phương thức run()
    
    // Tạo và bắt đầu một luồng khác
    MyThread thread2 = new MyThread();
    thread2.setName("MyThread-2");
    thread2.start();
    
    System.out.println("Main thread tiếp tục thực thi...");
}
```

#### 2. Triển khai giao diện Runnable

```java
class MyRunnable implements Runnable {
    @Override
    public void run() {
        // Mã lệnh sẽ được thực thi trong luồng mới
        String threadName = Thread.currentThread().getName();
        for (int i = 1; i <= 5; i++) {
            System.out.println("Thread [" + threadName + "]: Số " + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println("Thread bị gián đoạn");
                return;
            }
        }
        System.out.println("Thread [" + threadName + "] kết thúc.");
    }
}

// Sử dụng
public static void main(String[] args) {
    // Tạo đối tượng Runnable
    MyRunnable myRunnable = new MyRunnable();
    
    // Tạo thread với Runnable
    Thread thread1 = new Thread(myRunnable, "Thread-A");
    Thread thread2 = new Thread(myRunnable, "Thread-B");
    
    // Bắt đầu các thread
    thread1.start();
    thread2.start();
    
    System.out.println("Main thread tiếp tục thực thi...");
}
```

#### 3. Sử dụng biểu thức lambda (Java 8+)

```java
public static void main(String[] args) {
    // Tạo thread với biểu thức lambda
    Thread thread = new Thread(() -> {
        String name = Thread.currentThread().getName();
        for (int i = 1; i <= 5; i++) {
            System.out.println("Thread [" + name + "]: Số " + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println("Thread bị gián đoạn");
                return;
            }
        }
        System.out.println("Thread [" + name + "] kết thúc.");
    }, "Lambda-Thread");
    
    thread.start();
    System.out.println("Main thread tiếp tục thực thi...");
}
```

### Quản lý luồng

#### Bắt đầu luồng (start)

Khi gọi `thread.start()`, JVM sẽ cấp phát tài nguyên, lên lịch và gọi phương thức `run()`. Luồng mới sẽ chạy song song với các luồng khác.

```java
Thread thread = new Thread(() -> System.out.println("Luồng mới đang chạy"));
thread.start(); // Bắt đầu luồng mới
```

#### Chờ luồng kết thúc (join)

Phương thức `join()` khiến luồng hiện tại đợi cho đến khi một luồng khác hoàn thành.

```java
Thread worker = new Thread(() -> {
    System.out.println("Worker bắt đầu...");
    try {
        Thread.sleep(2000); // Giả lập công việc kéo dài 2 giây
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
    System.out.println("Worker hoàn thành!");
});

worker.start();
System.out.println("Main thread đang đợi worker...");

try {
    worker.join(); // Main thread sẽ đợi ở đây cho đến khi worker kết thúc
} catch (InterruptedException e) {
    e.printStackTrace();
}

System.out.println("Main thread tiếp tục sau khi worker hoàn thành");
```

#### Tạm dừng luồng (sleep)

Phương thức `Thread.sleep(milliseconds)` tạm dừng luồng hiện tại trong khoảng thời gian xác định.

```java
try {
    System.out.println("Bắt đầu tạm dừng...");
    Thread.sleep(3000); // Tạm dừng 3 giây
    System.out.println("Tiếp tục sau khi tạm dừng!");
} catch (InterruptedException e) {
    System.out.println("Bị gián đoạn trong khi sleep!");
}
```

#### Ngắt một luồng (interrupt)

Phương thức `interrupt()` đánh dấu một luồng là "bị ngắt" và thường được sử dụng để yêu cầu luồng kết thúc sớm.

```java
Thread workerThread = new Thread(() -> {
    try {
        System.out.println("Worker thread bắt đầu...");
        while (!Thread.currentThread().isInterrupted()) {
            System.out.println("Đang xử lý...");
            Thread.sleep(500);
        }
    } catch (InterruptedException e) {
        // Thread.sleep() sẽ ném InterruptedException khi thread bị interrupt
        System.out.println("Worker thread bị ngắt trong khi sleep");
        return; // Thoát khỏi phương thức run()
    }
    System.out.println("Worker thread kết thúc bình thường");
});

workerThread.start();

// Để thread chạy trong 2 giây
try {
    Thread.sleep(2000);
} catch (InterruptedException e) {
    e.printStackTrace();
}

// Ngắt thread
System.out.println("Main thread yêu cầu worker dừng lại...");
workerThread.interrupt();
```

#### Ưu tiên luồng (priority)

Có thể thiết lập độ ưu tiên cho các luồng (1-10, mặc định là 5):

```java
Thread highPriorityThread = new Thread(() -> {
    // mã lệnh...
});
highPriorityThread.setPriority(Thread.MAX_PRIORITY); // 10

Thread lowPriorityThread = new Thread(() -> {
    // mã lệnh...
});
lowPriorityThread.setPriority(Thread.MIN_PRIORITY); // 1
```

### Đồng bộ hóa (Synchronization)

Khi nhiều luồng cùng truy cập vào một tài nguyên chung, có thể xảy ra tình trạng không nhất quán dữ liệu (race condition). Đồng bộ hóa giúp đảm bảo tính toàn vẹn của dữ liệu.

#### Vấn đề race condition

```java
class Counter {
    private int count = 0;
    
    public void increment() {
        count++;  // Không an toàn trong đa luồng!
    }
    
    public int getCount() {
        return count;
    }
}

// Sử dụng với đa luồng
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

// Đợi cả hai luồng kết thúc
try {
    t1.join();
    t2.join();
} catch (InterruptedException e) {
    e.printStackTrace();
}

// Kết quả có thể nhỏ hơn 20000 do race condition
System.out.println("Giá trị cuối cùng: " + counter.getCount());
```

#### Đồng bộ hóa bằng từ khóa synchronized

```java
class SynchronizedCounter {
    private int count = 0;
    
    // Phương thức đồng bộ - chỉ một luồng có thể vào tại một thời điểm
    public synchronized void increment() {
        count++;
    }
    
    public synchronized int getCount() {
        return count;
    }
}

// Hoặc sử dụng khối đồng bộ
class SynchronizedCounter2 {
    private int count = 0;
    private final Object lock = new Object(); // Đối tượng khóa
    
    public void increment() {
        // Chỉ đồng bộ hóa đoạn mã quan trọng
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

#### Ví dụ thực tế: Đồng bộ hóa truy cập tập tin

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
                System.err.println("Lỗi khi ghi log: " + e.getMessage());
            }
        }
    }
}

// Sử dụng
FileLogger logger = new FileLogger("application.log");

Runnable logTask = () -> {
    for (int i = 1; i <= 5; i++) {
        logger.logMessage("Bản ghi #" + i);
        try {
            Thread.sleep(200);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
};

// Tạo nhiều luồng cùng ghi log
new Thread(logTask, "Logger-A").start();
new Thread(logTask, "Logger-B").start();
new Thread(logTask, "Logger-C").start();
```

### Các vấn đề trong lập trình đa luồng

#### Deadlock (Bế tắc)

Deadlock xảy ra khi hai hoặc nhiều luồng chờ đợi lẫn nhau vô thời hạn.

```java
public static void demonstrateDeadlock() {
    final Object resource1 = new Object();
    final Object resource2 = new Object();
    
    // Thread 1: Lấy resource1, sau đó cố gắng lấy resource2
    Thread t1 = new Thread(() -> {
        synchronized (resource1) {
            System.out.println("Thread 1: Đã lấy resource1");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            
            System.out.println("Thread 1: Đang cố lấy resource2");
            synchronized (resource2) {
                System.out.println("Thread 1: Đã lấy resource2");
            }
        }
    });
    
    // Thread 2: Lấy resource2, sau đó cố gắng lấy resource1
    Thread t2 = new Thread(() -> {
        synchronized (resource2) {
            System.out.println("Thread 2: Đã lấy resource2");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            
            System.out.println("Thread 2: Đang cố lấy resource1");
            synchronized (resource1) {
                System.out.println("Thread 2: Đã lấy resource1");
            }
        }
    });
    
    t1.start();
    t2.start();
}
```

#### Tránh Deadlock

Một cách để tránh deadlock là luôn lấy tài nguyên theo thứ tự nhất định:

```java
public static void avoidDeadlock() {
    final Object resource1 = new Object();
    final Object resource2 = new Object();
    
    // Cả hai thread đều lấy resource1 trước, rồi mới lấy resource2
    Thread t1 = new Thread(() -> {
        synchronized (resource1) {
            System.out.println("Thread 1: Đã lấy resource1");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            
            synchronized (resource2) {
                System.out.println("Thread 1: Đã lấy resource2");
            }
        }
    });
    
    Thread t2 = new Thread(() -> {
        synchronized (resource1) {
            System.out.println("Thread 2: Đã lấy resource1");
            try { Thread.sleep(100); } catch (InterruptedException e) {}
            
            synchronized (resource2) {
                System.out.println("Thread 2: Đã lấy resource2");
            }
        }
    });
    
    t1.start();
    t2.start();
}
```

### Ví dụ thực tế: Mô phỏng nhà hàng

```java
class Restaurant {
    private final Object kitchenLock = new Object();
    private int pendingOrders = 0;
    private final int MAX_PENDING_ORDERS = 5;
    
    // Chef (đầu bếp) làm món ăn
    class Chef implements Runnable {
        @Override
        public void run() {
            while (true) {
                cookMeal();
                try {
                    // Thời gian để nấu một món ăn
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
                        System.out.println("Đầu bếp: Không có đơn hàng, đang chờ...");
                        kitchenLock.wait(); // Đợi đến khi có đơn hàng mới
                    } catch (InterruptedException e) {
                        return;
                    }
                }
                
                pendingOrders--;
                System.out.println("Đầu bếp: Đã làm xong một món, còn lại " + pendingOrders + " đơn hàng");
                kitchenLock.notifyAll(); // Thông báo cho Waiter biết đã có món ăn sẵn sàng
            }
        }
    }
    
    // Waiter (phục vụ) nhận đơn hàng
    class Waiter implements Runnable {
        @Override
        public void run() {
            while (true) {
                takeOrder();
                try {
                    // Thời gian để lấy một đơn hàng
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
                        System.out.println("Phục vụ: Bếp quá tải, đang chờ...");
                        kitchenLock.wait(); // Đợi đến khi bếp bớt tải
                    } catch (InterruptedException e) {
                        return;
                    }
                }
                
                pendingOrders++;
                System.out.println("Phục vụ: Đã nhận đơn hàng mới, hiện có " + pendingOrders + " đơn chờ");
                kitchenLock.notify(); // Thông báo cho Chef biết có đơn hàng mới
            }
        }
    }
    
    public void startSimulation() {
        Thread chefThread = new Thread(new Chef(), "Chef");
        Thread waiterThread = new Thread(new Waiter(), "Waiter");
        
        chefThread.start();
        waiterThread.start();
        
        // Chạy mô phỏng trong 10 giây
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        // Kết thúc các thread
        chefThread.interrupt();
        waiterThread.interrupt();
        System.out.println("Mô phỏng nhà hàng kết thúc!");
    }
}
```

### Thực hành: Tạo chương trình tải file song song

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
        
        // Tạo thư mục đích
        File downloadDir = new File("downloads");
        if (!downloadDir.exists()) {
            downloadDir.mkdir();
        }
        
        System.out.println("Bắt đầu tải song song " + urls.length + " file...");
        long startTime = System.currentTimeMillis();
        
        // Tạo ExecutorService với thread pool
        ExecutorService executor = Executors.newFixedThreadPool(3);
        
        // Tạo danh sách các tác vụ tải file
        List<Future<DownloadResult>> results = new ArrayList<>();
        
        for (String url : urls) {
            // Tạo tác vụ tải cho mỗi URL
            Callable<DownloadResult> downloadTask = new DownloadTask(url, downloadDir);
            
            // Gửi tác vụ đến executor và lưu Future để theo dõi
            Future<DownloadResult> future = executor.submit(downloadTask);
            results.add(future);
        }
        
        // Thu thập kết quả
        for (Future<DownloadResult> future : results) {
            try {
                DownloadResult result = future.get(); // Đợi cho đến khi tác vụ hoàn thành
                System.out.println("Đã tải: " + result.getFileName() + 
                                   " (" + result.getFileSize() + " bytes) trong " + 
                                   result.getElapsedTime() + "ms");
            } catch (InterruptedException | ExecutionException e) {
                System.err.println("Lỗi khi tải file: " + e.getMessage());
            }
        }
        
        // Đóng executor
        executor.shutdown();
        
        long endTime = System.currentTimeMillis();
        System.out.println("Hoàn tất! Tổng thời gian: " + (endTime - startTime) + "ms");
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
                             "] đang tải: " + fileName);
            
            long fileSize = 0;
            try (BufferedInputStream in = new BufferedInputStream(url.openStream());
                 FileOutputStream fos = new FileOutputStream(outputFile)) {
                
                byte[] buffer = new byte[4096];
                int bytesRead;
                
                while ((bytesRead = in.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                    fileSize += bytesRead;
                    
                    // Mô phỏng mạng chậm
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

---

## 🧑‍🏫 Bài 3: Lập trình đồng thời (Concurrency)

Lập trình đồng thời (Concurrency) là kỹ thuật cho phép nhiều tác vụ được thực hiện đồng thời, giúp tăng hiệu suất và tối ưu hóa việc sử dụng tài nguyên. Java cung cấp nhiều API mạnh mẽ để xây dựng các ứng dụng đồng thời hiệu quả và an toàn.

### Concurrency API trong Java

Java SE 5 giới thiệu gói `java.util.concurrent` với các lớp và giao diện giúp quản lý thread một cách hiệu quả hơn, an toàn hơn so với cách truyền thống.

#### ExecutorService và Thread Pool

`ExecutorService` là một service giúp quản lý các thread và tác vụ. `ThreadPool` là một nhóm các thread được tạo trước và sẵn sàng thực hiện công việc, giúp:

- Tái sử dụng thread, giảm chi phí khởi tạo
- Quản lý số lượng thread đồng thời
- Cải thiện hiệu suất với số lượng thread phù hợp

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ExecutorServiceExample {
    public static void main(String[] args) {
        // Tạo thread pool với kích thước cố định là 5 thread
        ExecutorService executor = Executors.newFixedThreadPool(5);
        
        // Gửi 10 tác vụ cho executor
        for (int i = 1; i <= 10; i++) {
            final int taskId = i;
            executor.execute(() -> {
                System.out.println("Đang thực hiện tác vụ " + taskId + 
                                   " bởi thread " + Thread.currentThread().getName());
                try {
                    // Giả lập công việc mất thời gian
                    Thread.sleep((long)(Math.random() * 1000));
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
                System.out.println("Tác vụ " + taskId + " hoàn thành");
            });
        }
        
        // Đóng executor sau khi hoàn thành
        executor.shutdown();
        
        // Đợi cho đến khi tất cả tác vụ hoàn thành
        while (!executor.isTerminated()) {
            // Chờ
        }
        
        System.out.println("Tất cả tác vụ đã hoàn thành");
    }
}
```

#### Các loại Executor phổ biến

1. **Fixed Thread Pool**: Số lượng thread cố định

   ```java
   ExecutorService fixedPool = Executors.newFixedThreadPool(5);
   ```

2. **Cached Thread Pool**: Tự động tạo thread mới khi cần, tái sử dụng các thread rảnh

   ```java
   ExecutorService cachedPool = Executors.newCachedThreadPool();
   ```

3. **Single Thread Executor**: Chỉ sử dụng 1 thread duy nhất

   ```java
   ExecutorService singleThreadExecutor = Executors.newSingleThreadExecutor();
   ```

4. **Scheduled Thread Pool**: Cho phép lên lịch thực thi các tác vụ

   ```java
   ScheduledExecutorService scheduledPool = Executors.newScheduledThreadPool(3);
   ```

### Callable và Future

`Callable` tương tự như `Runnable` nhưng có thể trả về kết quả và ném ra ngoại lệ.
`Future` là một đối tượng đại diện cho kết quả không đồng bộ, cho phép kiểm tra trạng thái và lấy kết quả khi hoàn thành.

```java
import java.util.concurrent.*;
import java.util.*;

public class CallableFutureExample {
    public static void main(String[] args) {
        ExecutorService executor = Executors.newFixedThreadPool(3);
        
        // Danh sách các Future để lưu kết quả
        List<Future<Integer>> resultList = new ArrayList<>();
        
        // Tạo và gửi 5 tác vụ Callable
        for (int i = 1; i <= 5; i++) {
            final int taskId = i;
            Callable<Integer> task = () -> {
                System.out.println("Đang tính toán tác vụ " + taskId);
                Thread.sleep(1000); // Giả lập xử lý
                // Giả sử tính tổng các số từ 1 đến taskId
                int sum = 0;
                for (int j = 1; j <= taskId; j++) {
                    sum += j;
                }
                return sum;
            };
            
            // Gửi tác vụ và lưu Future
            Future<Integer> future = executor.submit(task);
            resultList.add(future);
        }
        
        // Xử lý kết quả
        for (int i = 0; i < resultList.size(); i++) {
            try {
                // get() sẽ chờ cho đến khi tác vụ hoàn thành
                Integer result = resultList.get(i).get();
                System.out.println("Tác vụ " + (i + 1) + " có kết quả: " + result);
            } catch (InterruptedException | ExecutionException e) {
                e.printStackTrace();
            }
        }
        
        executor.shutdown();
    }
}
```

### CompletableFuture trong Java 8+

`CompletableFuture` là một lớp mới trong Java 8, mở rộng từ `Future` với nhiều phương thức hữu ích cho lập trình không đồng bộ:

```java
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;

public class CompletableFutureExample {
    public static void main(String[] args) {
        // Tạo CompletableFuture không đồng bộ
        CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
            try {
                System.out.println("Đang xử lý tác vụ...");
                TimeUnit.SECONDS.sleep(2);
                return "Kết quả từ tác vụ không đồng bộ";
            } catch (InterruptedException e) {
                return "Tác vụ bị gián đoạn";
            }
        });
        
        // Thêm callback để xử lý kết quả khi hoàn thành
        future.thenAccept(result -> {
            System.out.println("Đã nhận kết quả: " + result);
        });
        
        // Thêm xử lý khi có lỗi
        future.exceptionally(ex -> {
            System.out.println("Lỗi xảy ra: " + ex.getMessage());
            return "Giá trị mặc định do lỗi";
        });
        
        // Kết hợp hai tác vụ không đồng bộ
        CompletableFuture<String> future1 = CompletableFuture.supplyAsync(() -> {
            try {
                TimeUnit.SECONDS.sleep(1);
                return "Dữ liệu từ nguồn 1";
            } catch (InterruptedException e) {
                return "Lỗi từ nguồn 1";
            }
        });
        
        CompletableFuture<String> future2 = CompletableFuture.supplyAsync(() -> {
            try {
                TimeUnit.SECONDS.sleep(2);
                return "Dữ liệu từ nguồn 2";
            } catch (InterruptedException e) {
                return "Lỗi từ nguồn 2";
            }
        });
        
        // Kết hợp kết quả từ cả hai nguồn
        CompletableFuture<String> combinedFuture = future1.thenCombine(future2, 
            (result1, result2) -> result1 + " + " + result2);
        
        combinedFuture.thenAccept(System.out::println);
        
        // Đảm bảo chương trình không kết thúc trước khi tác vụ hoàn thành
        try {
            TimeUnit.SECONDS.sleep(5);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
```

### Đồng bộ hóa nâng cao với Lock Interface

Java cung cấp giao diện `Lock` trong gói `java.util.concurrent.locks` như một giải pháp nâng cao cho từ khóa `synchronized`:

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
        lock.lock();  // Khóa tài nguyên
        try {
            if (amount > 0) {
                double newBalance = balance + amount;
                // Giả lập độ trễ để dễ thấy vấn đề race condition
                Thread.sleep(100);
                balance = newBalance;
                System.out.println("Đã nạp: " + amount + ", Số dư mới: " + balance);
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            lock.unlock();  // Luôn đảm bảo unlock trong finally
        }
    }
    
    public boolean withdraw(double amount) {
        lock.lock();
        try {
            if (amount <= balance) {
                double newBalance = balance - amount;
                Thread.sleep(100);
                balance = newBalance;
                System.out.println("Đã rút: " + amount + ", Số dư mới: " + balance);
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
    
    // Sử dụng tryLock để tránh deadlock
    public boolean transfer(BankAccount target, double amount) {
        // Cố gắng khóa tài khoản nguồn
        if (lock.tryLock()) {
            try {
                // Cố gắng khóa tài khoản đích
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
        // Nếu không thể khóa cả hai tài khoản
        System.out.println("Không thể chuyển khoản lúc này, vui lòng thử lại sau");
        return false;
    }
}
```

### Semaphore và Latch

`Semaphore` kiểm soát số lượng thread có thể truy cập vào một tài nguyên đồng thời:

```java
import java.util.concurrent.Semaphore;

public class SemaphoreExample {
    public static void main(String[] args) {
        // Giả lập một nhóm connection pool với 3 connections
        Semaphore connectionPool = new Semaphore(3);
        
        // Tạo 10 thread cùng truy cập connection pool
        for (int i = 1; i <= 10; i++) {
            final int clientId = i;
            new Thread(() -> {
                try {
                    System.out.println("Client " + clientId + " đang chờ kết nối...");
                    connectionPool.acquire(); // Lấy 1 permit (connection)
                    System.out.println("Client " + clientId + " đã lấy được kết nối!");
                    
                    // Giả lập thời gian sử dụng connection
                    Thread.sleep((long)(Math.random() * 2000) + 1000);
                    
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    // Giải phóng connection khi hoàn thành
                    connectionPool.release();
                    System.out.println("Client " + clientId + " đã giải phóng kết nối!");
                }
            }).start();
        }
    }
}
```

`CountDownLatch` là một công cụ đồng bộ hóa cho phép một hoặc nhiều thread chờ đợi cho đến khi một tập hợp các hoạt động hoàn thành:

```java
import java.util.concurrent.CountDownLatch;

public class CountDownLatchExample {
    public static void main(String[] args) throws InterruptedException {
        // Tạo latch với số đếm là 3
        CountDownLatch latch = new CountDownLatch(3);
        
        System.out.println("Ứng dụng đang khởi động...");
        
        // Khởi chạy 3 service
        for (int i = 1; i <= 3; i++) {
            final int serviceId = i;
            new Thread(() -> {
                try {
                    System.out.println("Service " + serviceId + " đang khởi động...");
                    // Giả lập thời gian khởi động
                    Thread.sleep((long)(Math.random() * 2000) + 1000);
                    System.out.println("Service " + serviceId + " đã sẵn sàng!");
                    
                    // Đánh dấu service này đã hoàn thành
                    latch.countDown();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }).start();
        }
        
        // Đợi cho đến khi tất cả 3 service đều sẵn sàng
        latch.await();
        
        System.out.println("Tất cả service đã sẵn sàng! Ứng dụng bắt đầu xử lý request...");
    }
}
```

### Biến nguyên tử (Atomic Variables)

Các biến nguyên tử trong gói `java.util.concurrent.atomic` cung cấp các hoạt động nguyên tử mà không cần khóa:

```java
import java.util.concurrent.atomic.AtomicInteger;

public class AtomicVariableExample {
    // Biến đếm truyền thống (không an toàn với đa luồng)
    private static int normalCounter = 0;
    
    // Biến đếm nguyên tử (thread-safe)
    private static AtomicInteger atomicCounter = new AtomicInteger(0);
    
    public static void main(String[] args) throws InterruptedException {
        // Tạo nhiều thread cùng tăng bộ đếm
        Thread[] threads = new Thread[10];
        
        for (int i = 0; i < threads.length; i++) {
            threads[i] = new Thread(() -> {
                for (int j = 0; j < 1000; j++) {
                    normalCounter++;         // Không an toàn, có thể bị mất mát
                    atomicCounter.incrementAndGet();  // An toàn, nguyên tử
                }
            });
            threads[i].start();
        }
        
        // Đợi tất cả thread hoàn thành
        for (Thread thread : threads) {
            thread.join();
        }
        
        System.out.println("Giá trị bộ đếm thông thường: " + normalCounter);
        System.out.println("Giá trị bộ đếm nguyên tử: " + atomicCounter.get());
    }
}
```

### ConcurrentHashMap và CopyOnWriteArrayList

Các Collection đồng thời được thiết kế đặc biệt để làm việc hiệu quả trong môi trường đa luồng:

```java
import java.util.*;
import java.util.concurrent.*;

public class ConcurrentCollectionsExample {
    public static void main(String[] args) {
        // HashMap thông thường (không thread-safe)
        Map<String, Integer> normalMap = new HashMap<>();
        
        // ConcurrentHashMap (thread-safe)
        Map<String, Integer> concurrentMap = new ConcurrentHashMap<>();
        
        // ArrayList thông thường (không thread-safe)
        List<String> normalList = new ArrayList<>();
        
        // CopyOnWriteArrayList (thread-safe)
        List<String> concurrentList = new CopyOnWriteArrayList<>();
        
        // Tạo và chạy nhiều thread cùng truy cập vào collections
        Runnable task = () -> {
            // Thêm phần tử vào danh sách
            String threadName = Thread.currentThread().getName();
            concurrentList.add(threadName);
            
            // Cập nhật giá trị trong map
            concurrentMap.put(threadName, concurrentList.size());
            
            // Đọc tất cả các phần tử từ danh sách
            for (String item : concurrentList) {
                // Thao tác đọc không bị chặn
                System.out.println(threadName + " đọc: " + item);
            }
            
            // Truy xuất và cập nhật giá trị trong map
            concurrentMap.computeIfPresent(threadName, (key, oldValue) -> oldValue + 1);
        };
        
        // Khởi chạy 10 thread
        List<Thread> threads = new ArrayList<>();
        for (int i = 1; i <= 10; i++) {
            Thread t = new Thread(task, "Thread-" + i);
            threads.add(t);
            t.start();
        }
        
        // Đợi tất cả thread hoàn thành
        for (Thread t : threads) {
            try {
                t.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        
        // Hiển thị kết quả
        System.out.println("\nKết quả cuối cùng:");
        System.out.println("ConcurrentList size: " + concurrentList.size());
        System.out.println("ConcurrentMap entries: " + concurrentMap);
    }
}
```

### Ví dụ thực tế: Xử lý dữ liệu song song

```java
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;

public class ParallelDataProcessingExample {
    
    // Giả lập dữ liệu cần xử lý
    private static List<String> generateData(int size) {
        List<String> data = new ArrayList<>(size);
        for (int i = 0; i < size; i++) {
            data.add("Item-" + i);
        }
        return data;
    }
    
    // Giả lập hàm xử lý mất thời gian
    private static String processItem(String item) {
        try {
            // Giả lập xử lý tốn thời gian
            Thread.sleep(100);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        return item.toUpperCase() + "-PROCESSED";
    }
    
    public static void main(String[] args) throws InterruptedException, ExecutionException {
        // Tạo dữ liệu mẫu
        List<String> rawData = generateData(100);
        
        System.out.println("Bắt đầu xử lý " + rawData.size() + " phần tử");
        
        // 1. Xử lý tuần tự
        long startTime = System.currentTimeMillis();
        List<String> sequentialResult = processSequentially(rawData);
        long sequentialTime = System.currentTimeMillis() - startTime;
        
        System.out.println("Xử lý tuần tự hoàn thành trong " + sequentialTime + " ms");
        
        // 2. Xử lý với ExecutorService
        startTime = System.currentTimeMillis();
        List<String> executorResult = processWithExecutor(rawData);
        long executorTime = System.currentTimeMillis() - startTime;
        
        System.out.println("Xử lý với ExecutorService hoàn thành trong " + executorTime + " ms");
        
        // 3. Xử lý với CompletableFuture
        startTime = System.currentTimeMillis();
        List<String> completableFutureResult = processWithCompletableFuture(rawData);
        long completableFutureTime = System.currentTimeMillis() - startTime;
        
        System.out.println("Xử lý với CompletableFuture hoàn thành trong " + 
                         completableFutureTime + " ms");
        
        // 4. Xử lý với Parallel Streams (Java 8+)
        startTime = System.currentTimeMillis();
        List<String> parallelStreamResult = processWithParallelStream(rawData);
        long parallelStreamTime = System.currentTimeMillis() - startTime;
        
        System.out.println("Xử lý với Parallel Streams hoàn thành trong " + 
                         parallelStreamTime + " ms");
        
        // So sánh kết quả
        boolean allResultsMatch = sequentialResult.equals(executorResult) && 
                               executorResult.equals(completableFutureResult) &&
                               completableFutureResult.equals(parallelStreamResult);
        
        System.out.println("Tất cả kết quả giống nhau: " + allResultsMatch);
        System.out.println("\nTốc độ cải thiện:");
        double executorSpeedup = (double) sequentialTime / executorTime;
        double completableFutureSpeedup = (double) sequentialTime / completableFutureTime;
        double parallelStreamSpeedup = (double) sequentialTime / parallelStreamTime;
        
        System.out.printf("- ExecutorService: %.2fx nhanh hơn\n", executorSpeedup);
        System.out.printf("- CompletableFuture: %.2fx nhanh hơn\n", completableFutureSpeedup);
        System.out.printf("- Parallel Streams: %.2fx nhanh hơn\n", parallelStreamSpeedup);
    }
    
    // 1. Xử lý tuần tự
    private static List<String> processSequentially(List<String> data) {
        List<String> results = new ArrayList<>(data.size());
        for (String item : data) {
            results.add(processItem(item));
        }
        return results;
    }
    
    // 2. Xử lý với ExecutorService
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
    
    // 3. Xử lý với CompletableFuture
    private static List<String> processWithCompletableFuture(List<String> data) {
        List<CompletableFuture<String>> futures = data.stream()
            .map(item -> CompletableFuture.supplyAsync(() -> processItem(item)))
            .collect(Collectors.toList());
        
        return futures.stream()
            .map(CompletableFuture::join)
            .collect(Collectors.toList());
    }
    
    // 4. Xử lý với Parallel Streams
    private static List<String> processWithParallelStream(List<String> data) {
        return data.parallelStream()
            .map(ParallelDataProcessingExample::processItem)
            .collect(Collectors.toList());
    }
}
```

### Phương pháp hay nhất (Best Practices)

1. **Sử dụng ThreadPool thay vì tạo thread trực tiếp**
   - Để quản lý hiệu quả và tối ưu hóa việc sử dụng thread trong ứng dụng

2. **Luôn giải phóng tài nguyên**
   - Luôn gọi `shutdown()` trên `ExecutorService` khi không còn cần
   - Sử dụng try-with-resources hoặc finally để đảm bảo unlock các khóa

3. **Tránh deadlock**
   - Luôn lấy khóa theo cùng một thứ tự
   - Sử dụng tryLock() với timeout để tránh chờ vô hạn
   - Đừng giữ khóa khi thực hiện các hoạt động chặn hoặc kéo dài

4. **Giảm thiểu trạng thái chia sẻ**
   - Thiết kế để giảm thiểu dữ liệu chia sẻ
   - Sử dụng biến local thread khi có thể
   - Sử dụng `ThreadLocal` khi cần trạng thái riêng cho thread

5. **Xử lý ngoại lệ**
   - Không bỏ qua ngoại lệ trong các thread
   - Ghi lại hoặc truyền ngoại lệ lên cấp cao hơn
   - Kiểm tra InterruptedException và phục hồi trạng thái ngắt

6. **Hiểu rõ về tính nhất quán của bộ nhớ (Memory Consistency)**
   - Sử dụng biến volatile cho các flag đơn giản
   - Sử dụng synchronized hoặc Lock cho trạng thái phức tạp
   - Ưu tiên các lớp Atomic và Collection đồng thời

7. **Cân nhắc chi phí đồng bộ hóa**
   - Đồng bộ hóa thật sự cần thiết chỉ khi có nhiều thread ghi dữ liệu
   - Các hoạt động chỉ đọc không cần đồng bộ hóa phức tạp
   - Sử dụng cấu trúc như ReadWriteLock khi phù hợp

8. **Kiểm thử đa luồng**
   - Áp dụng công cụ phân tích tĩnh
   - Viết kiểm thử đa luồng với các tình huống tranh chấp
   - Thực hiện kiểm thử áp lực để tìm vấn đề về hiệu suất

### Bài tập thực hành: Xây dựng hệ thống Index tài liệu song song

```java
import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.*;

public class ParallelDocumentIndexer {
    
    // Lưu trữ chỉ mục: từ khóa -> danh sách tài liệu
    private final ConcurrentMap<String, Set<String>> index = new ConcurrentHashMap<>();
    
    // Thư mục chứa tài liệu cần index
    private final Path documentsDir;
    
    public ParallelDocumentIndexer(String documentsPath) {
        this.documentsDir = Paths.get(documentsPath);
    }
    
    public void buildIndex() throws IOException, InterruptedException {
        System.out.println("Bắt đầu tạo chỉ mục từ thư mục: " + documentsDir);
        
        // Lấy danh sách tất cả các file .txt
        List<Path> textFiles = Files.walk(documentsDir)
                                .filter(p -> p.toString().endsWith(".txt"))
                                .collect(Collectors.toList());
        
        System.out.println("Tìm thấy " + textFiles.size() + " tài liệu");
        
        ExecutorService executor = Executors.newWorkStealingPool();
        
        // Tạo futures để theo dõi tiến trình
        List<Future<?>> futures = new ArrayList<>();
        
        for (Path file : textFiles) {
            // Gửi tác vụ index cho mỗi file
            futures.add(executor.submit(() -> {
                try {
                    indexFile(file);
                } catch (IOException e) {
                    System.err.println("Lỗi khi index file " + file + ": " + e.getMessage());
                }
            }));
        }
        
        // Đợi tất cả tác vụ hoàn thành
        for (Future<?> future : futures) {
            future.get();
        }
        
        executor.shutdown();
        System.out.println("Hoàn thành! Đã index " + index.size() + " từ khóa.");
    }
    
    private void indexFile(Path file) throws IOException {
        System.out.println("Đang index file: " + file.getFileName());
        
        String fileContent = Files.readString(file);
        String fileName = file.getFileName().toString();
        
        // Tách nội dung thành các từ và xử lý
        String[] words = fileContent.toLowerCase()
                       .replaceAll("[^a-zàáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ\\s]", " ")
                       .split("\\s+");
        
        // Thêm từng từ vào index
        Arrays.stream(words)
            .filter(word -> word.length() > 2) // Bỏ qua từ quá ngắn
            .forEach(word -> {
                // putIfAbsent đảm bảo atomic, sau đó chúng ta cập nhật set
                index.computeIfAbsent(word, k -> ConcurrentHashMap.newKeySet())
                     .add(fileName);
            });
    }
    
    public Set<String> search(String keyword) {
        String normalizedKeyword = keyword.toLowerCase().trim();
        Set<String> result = index.getOrDefault(normalizedKeyword, Collections.emptySet());
        return new HashSet<>(result); // Trả về bản sao để tránh sửa đổi trực tiếp
    }
    
    public void searchMultipleKeywords(String[] keywords) {
        System.out.println("\nKết quả tìm kiếm:");
        
        Arrays.stream(keywords)
            .map(String::toLowerCase)
            .forEach(keyword -> {
                Set<String> documents = search(keyword);
                
                System.out.println("\"" + keyword + "\" xuất hiện trong " + 
                                  documents.size() + " tài liệu:");
                
                documents.forEach(doc -> System.out.println("  - " + doc));
            });
    }
    
    public static void main(String[] args) {
        try {
            // Đường dẫn đến thư mục chứa tài liệu cần index
            String documentsPath = "documents";
            
            // Tạo thư mục nếu chưa tồn tại
            Files.createDirectories(Paths.get(documentsPath));
            
            // Tạo vài file văn bản mẫu để thử nghiệm
            createSampleDocuments(documentsPath);
            
            // Khởi tạo và chạy indexer
            ParallelDocumentIndexer indexer = new ParallelDocumentIndexer(documentsPath);
            indexer.buildIndex();
            
            // Tìm kiếm một số từ khóa
            String[] searchTerms = {"java", "lập trình", "đồng thời", "concurrency", "thread"};
            indexer.searchMultipleKeywords(searchTerms);
            
        } catch (IOException | InterruptedException e) {
            System.err.println("Lỗi: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Tạo tài liệu mẫu để thử nghiệm
    private static void createSampleDocuments(String documentsPath) throws IOException {
        Map<String, String> sampleDocs = new HashMap<>();
        
        sampleDocs.put("java_basics.txt", 
            "Java là một ngôn ngữ lập trình hướng đối tượng phổ biến. " +
            "Nó được thiết kế để có số lượng triển khai phụ thuộc ít nhất có thể. " +
            "Các ứng dụng Java thường được biên dịch thành bytecode.");
            
        sampleDocs.put("concurrency_intro.txt",
            "Lập trình đồng thời (concurrency) trong Java cho phép thực thi nhiều luồng (thread) cùng một lúc. " +
            "Điều này giúp tận dụng tối đa các tài nguyên của máy tính đa nhân hiện đại.");
            
        sampleDocs.put("threading_models.txt",
            "Java hỗ trợ đa luồng (multithreading) thông qua lớp Thread và giao diện Runnable. " +
            "Từ Java 5, API đồng thời (java.util.concurrent) đã được giới thiệu với nhiều tính năng mạnh mẽ.");
            
        sampleDocs.put("memory_model.txt",
            "Mô hình bộ nhớ Java đặc tả cách các thread tương tác thông qua bộ nhớ. " +
            "Nó định nghĩa các quy tắc để đảm bảo các giá trị được đọc nhất quán giữa các thread khác nhau.");
            
        sampleDocs.put("performance_tips.txt",
            "Khi lập trình đa luồng trong Java, cần tránh các race condition và deadlock. " +
            "Sử dụng thread pool thay vì tạo thread trực tiếp sẽ giúp cải thiện hiệu suất ứng dụng.");
        
        // Ghi các file mẫu
        for (Map.Entry<String, String> entry : sampleDocs.entrySet()) {
            Path filePath = Paths.get(documentsPath, entry.getKey());
            Files.writeString(filePath, entry.getValue());
            System.out.println("Đã tạo file mẫu: " + filePath);
        }
    }
}
```

Với những kiến thức về lập trình đồng thời trong Java, bạn có thể xây dựng các ứng dụng hiệu quả, tận dụng tốt nguồn tài nguyên phần cứng và đạt hiệu suất cao hơn so với lập trình tuần tự truyền thống.

---

## 🧑‍🏫 Bài 4: Kết nối cơ sở dữ liệu với JDBC

### Tải Driver và tạo kết nối

```java
// Tải driver (chỉ cần làm một lần)
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    // Hoặc với SQLite: Class.forName("org.sqlite.JDBC");
} catch (ClassNotFoundException e) {
    System.out.println("Không tìm thấy Driver JDBC");
    e.printStackTrace();
}

// Tạo kết nối
String url = "jdbc:mysql://localhost:3306/mydatabase";
String username = "root";
String password = "password";

try (Connection connection = DriverManager.getConnection(url, username, password)) {
    System.out.println("Kết nối thành công đến cơ sở dữ liệu!");
    // Thao tác với database
} catch (SQLException e) {
    System.out.println("Kết nối thất bại!");
    e.printStackTrace();
}
```

### Sử dụng Statement để thực thi truy vấn

```java
public static void executeSimpleQuery(Connection conn) throws SQLException {
    // Tạo Statement
    try (Statement stmt = conn.createStatement()) {
        // Thực thi truy vấn SQL
        String sql = "SELECT id, name, email FROM users";
        ResultSet rs = stmt.executeQuery(sql);

        // Xử lý kết quả
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String email = rs.getString("email");

            System.out.println("ID: " + id + ", Tên: " + name + ", Email: " + email);
        }
    }
}
```

### Sử dụng PreparedStatement để thực thi truy vấn an toàn

```java
public static void findUserById(Connection conn, int userId) throws SQLException {
    String sql = "SELECT id, name, email FROM users WHERE id = ?";

    // Tạo PreparedStatement
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        // Đặt tham số
        pstmt.setInt(1, userId);

        // Thực thi truy vấn
        ResultSet rs = pstmt.executeQuery();

        // Xử lý kết quả
        if (rs.next()) {
            String name = rs.getString("name");
            String email = rs.getString("email");

            System.out.println("Tìm thấy người dùng:");
            System.out.println("ID: " + userId + ", Tên: " + name + ", Email: " + email);
        } else {
            System.out.println("Không tìm thấy người dùng với ID: " + userId);
        }
    }
}
```

### Sử dụng try-with-resources với JDBC

```java
public static void safeDatabaseOperation() {
    String url = "jdbc:mysql://localhost:3306/mydatabase";
    String username = "root";
    String password = "password";

    // try-with-resources sẽ tự động đóng Connection, Statement và ResultSet
    try (
        Connection conn = DriverManager.getConnection(url, username, password);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS user_count FROM users")
    ) {
        if (rs.next()) {
            int count = rs.getInt("user_count");
            System.out.println("Tổng số người dùng: " + count);
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi thao tác với cơ sở dữ liệu:");
        e.printStackTrace();
    }
}
```

### Ví dụ thực tế - Kết nối và truy vấn cơ sở dữ liệu

```java
import java.sql.*;

public class JDBCExample {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/library_db";
        String username = "root";
        String password = "password";

        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            System.out.println("Kết nối thành công đến cơ sở dữ liệu!");

            // Tìm tất cả sách xuất bản sau năm 2020
            findBooksByYear(conn, 2020);

            // Tìm sách theo tác giả
            findBooksByAuthor(conn, "Nguyễn Nhật Ánh");

        } catch (SQLException e) {
            System.out.println("Lỗi kết nối: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void findBooksByYear(Connection conn, int year) throws SQLException {
        String sql = "SELECT id, title, author, published_year FROM books WHERE published_year > ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, year);
            ResultSet rs = pstmt.executeQuery();

            System.out.println("\nSách xuất bản sau năm " + year + ":");
            while (rs.next()) {
                System.out.printf("ID: %d, Tiêu đề: %s, Tác giả: %s, Năm: %d\n",
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
            pstmt.setString(1, "%" + authorName + "%");  // Tìm kiếm mờ
            ResultSet rs = pstmt.executeQuery();

            System.out.println("\nSách của tác giả có tên '" + authorName + "':");
            boolean found = false;

            while (rs.next()) {
                found = true;
                System.out.printf("ID: %d, Tiêu đề: %s, Năm xuất bản: %d\n",
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getInt("published_year"));
            }

            if (!found) {
                System.out.println("Không tìm thấy sách nào của tác giả này.");
            }
        }
    }
}
```

---

## 🧑‍🏫 Bài 5: Thao tác CRUD với JDBC

### Tạo bảng trong cơ sở dữ liệu

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
        System.out.println("Bảng 'students' đã được tạo hoặc đã tồn tại");
    }
}
```

### Thêm dữ liệu (Create)

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
            System.out.println("Đã thêm thành công sinh viên: " + name);
        }
    }
}
```

### Truy vấn dữ liệu (Read)

```java
public static void getAllStudents(Connection conn) throws SQLException {
    String sql = "SELECT id, name, email, age, gpa FROM students";

    try (Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {

        if (!rs.isBeforeFirst()) {
            System.out.println("Không có sinh viên nào trong cơ sở dữ liệu");
            return;
        }

        System.out.println("\n----- DANH SÁCH SINH VIÊN -----");
        System.out.printf("%-5s %-20s %-25s %-5s %-5s\n",
                        "ID", "Họ tên", "Email", "Tuổi", "GPA");
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

            System.out.println("\n----- TÌM KIẾM SINH VIÊN -----");
            System.out.printf("%-5s %-20s %-25s %-5s %-5s\n",
                            "ID", "Họ tên", "Email", "Tuổi", "GPA");
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
                System.out.println("Không tìm thấy sinh viên nào có tên \"" + searchName + "\"");
            }
        }
    }
}
```

### Cập nhật dữ liệu (Update)

```java
public static void updateStudentGPA(Connection conn, int studentId, double newGPA)
        throws SQLException {
    String sql = "UPDATE students SET gpa = ? WHERE id = ?";

    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setDouble(1, newGPA);
        pstmt.setInt(2, studentId);

        int rowsUpdated = pstmt.executeUpdate();
        if (rowsUpdated > 0) {
            System.out.println("Đã cập nhật GPA của sinh viên có ID = " + studentId);
        } else {
            System.out.println("Không tìm thấy sinh viên có ID = " + studentId);
        }
    }
}
```

### Xóa dữ liệu (Delete)

```java
public static void deleteStudent(Connection conn, int studentId) throws SQLException {
    // Trước tiên, kiểm tra xem sinh viên có tồn tại không
    String checkSql = "SELECT name FROM students WHERE id = ?";
    try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
        checkStmt.setInt(1, studentId);

        try (ResultSet rs = checkStmt.executeQuery()) {
            if (rs.next()) {
                String studentName = rs.getString("name");

                // Sinh viên tồn tại, tiến hành xóa
                String deleteSql = "DELETE FROM students WHERE id = ?";
                try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                    deleteStmt.setInt(1, studentId);

                    int rowsDeleted = deleteStmt.executeUpdate();
                    System.out.println("Đã xóa sinh viên: " + studentName);
                }
            } else {
                System.out.println("Không tìm thấy sinh viên có ID = " + studentId);
            }
        }
    }
}
```

### Ví dụ thực tế - Quản lý sinh viên CRUD hoàn chỉnh

```java
import java.sql.*;
import java.util.Scanner;

public class StudentManagementSystem {
    // Thông tin kết nối CSDL
    private static final String URL = "jdbc:mysql://localhost:3306/school_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "password";

    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        try {
            // Tải driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Tạo kết nối
            try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
                // Tạo bảng nếu chưa tồn tại
                createTable(conn);

                boolean running = true;
                while (running) {
                    displayMenu();
                    int choice = scanner.nextInt();
                    scanner.nextLine(); // Đọc newline

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
                            System.out.println("Cảm ơn bạn đã sử dụng chương trình!");
                            break;
                        default:
                            System.out.println("Lựa chọn không hợp lệ!");
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Không tìm thấy Driver JDBC: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void displayMenu() {
        System.out.println("\n----- HỆ THỐNG QUẢN LÝ SINH VIÊN -----");
        System.out.println("1. Thêm sinh viên mới");
        System.out.println("2. Xem tất cả sinh viên");
        System.out.println("3. Tìm kiếm sinh viên theo tên");
        System.out.println("4. Cập nhật GPA của sinh viên");
        System.out.println("5. Xóa sinh viên");
        System.out.println("0. Thoát");
        System.out.print("Chọn chức năng: ");
    }

    private static void addNewStudent(Connection conn) throws SQLException {
        System.out.println("\n----- THÊM SINH VIÊN MỚI -----");

        System.out.print("Nhập tên sinh viên: ");
        String name = scanner.nextLine();

        System.out.print("Nhập email: ");
        String email = scanner.nextLine();

        System.out.print("Nhập tuổi: ");
        int age = scanner.nextInt();

        System.out.print("Nhập GPA: ");
        double gpa = scanner.nextDouble();
        scanner.nextLine(); // Đọc newline

        addStudent(conn, name, email, age, gpa);
    }

    private static void viewAllStudents(Connection conn) throws SQLException {
        getAllStudents(conn);
    }

    private static void searchStudent(Connection conn) throws SQLException {
        System.out.print("\nNhập tên sinh viên cần tìm: ");
        String searchName = scanner.nextLine();

        findStudentByName(conn, searchName);
    }

    private static void updateStudent(Connection conn) throws SQLException {
        System.out.print("\nNhập ID của sinh viên cần cập nhật: ");
        int id = scanner.nextInt();

        System.out.print("Nhập GPA mới: ");
        double newGPA = scanner.nextDouble();
        scanner.nextLine(); // Đọc newline

        updateStudentGPA(conn, id, newGPA);
    }

    private static void deleteStudentRecord(Connection conn) throws SQLException {
        System.out.print("\nNhập ID của sinh viên cần xóa: ");
        int id = scanner.nextInt();
        scanner.nextLine(); // Đọc newline

        System.out.print("Bạn có chắc muốn xóa sinh viên này? (y/n): ");
        String confirm = scanner.nextLine();

        if (confirm.equalsIgnoreCase("y")) {
            deleteStudent(conn, id);
        } else {
            System.out.println("Đã hủy thao tác xóa");
        }
    }

    // Phương thức CRUD khác đã được định nghĩa ở trên...
}
```

### Xử lý lỗi và Transaction

```java
public static void registerStudentWithCourses(Connection conn, String studentName,
                                            String email, int[] courseIds) throws SQLException {
    // Vô hiệu hóa auto-commit để sử dụng transaction
    boolean autoCommit = conn.getAutoCommit();
    conn.setAutoCommit(false);

    try {
        // 1. Thêm sinh viên mới
        String insertStudentSql = "INSERT INTO students (name, email) VALUES (?, ?)";
        int studentId;

        try (PreparedStatement pstmt = conn.prepareStatement(insertStudentSql,
                                                        Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setString(1, studentName);
            pstmt.setString(2, email);
            pstmt.executeUpdate();

            // Lấy ID của sinh viên vừa thêm
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    studentId = rs.getInt(1);
                } else {
                    throw new SQLException("Không thể lấy ID của sinh viên vừa thêm");
                }
            }
        }

        // 2. Đăng ký sinh viên vào các khóa học
        String registerCourseSql = "INSERT INTO student_courses (student_id, course_id) VALUES (?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(registerCourseSql)) {
            for (int courseId : courseIds) {
                pstmt.setInt(1, studentId);
                pstmt.setInt(2, courseId);
                pstmt.executeUpdate();
            }
        }

        // Nếu mọi thứ OK, commit transaction
        conn.commit();
        System.out.println("Đã đăng ký sinh viên " + studentName + " với " +
                            courseIds.length + " khóa học");

    } catch (SQLException e) {
        // Nếu có lỗi, rollback
        try {
            System.out.println("Transaction bị lỗi, đang rollback...");
            conn.rollback();
        } catch (SQLException ex) {
            System.out.println("Lỗi khi rollback: " + ex.getMessage());
        }
        throw e;
    } finally {
        // Khôi phục trạng thái auto-commit
        conn.setAutoCommit(autoCommit);
    }
}
```

---

## 🧑‍🏫 Bài 6: Thực hành viết ứng dụng với JDBC

### Thiết kế cơ sở dữ liệu đơn giản

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

### Lớp kết nối cơ sở dữ liệu

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
                throw new SQLException("JDBC Driver không tìm thấy", e);
            }
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.out.println("Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }
    }
}
```

### Lớp DAO (Data Access Object) cho Student

```java
public class StudentDAO {
    private Connection conn;

    public StudentDAO() throws SQLException {
        this.conn = DatabaseConnection.getConnection();
    }

    // Thêm sinh viên mới
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

    // Lấy tất cả sinh viên
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

    // Tìm sinh viên theo mã
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

        return null; // Không tìm thấy
    }

    // Cập nhật thông tin sinh viên
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

    // Xóa sinh viên
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

### Lớp Student

```java
import java.util.Date;

public class Student {
    private int id;
    private String studentId;  // Mã sinh viên
    private String name;
    private Date birthDate;
    private String email;
    private String phone;

    // Constructor mặc định
    public Student() {
    }

    // Constructor với tham số
    public Student(String studentId, String name, Date birthDate, String email, String phone) {
        this.studentId = studentId;
        this.name = name;
        this.birthDate = birthDate;
        this.email = email;
        this.phone = phone;
    }

    // Getters và Setters
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

### Ứng dụng hoàn chỉnh với đa luồng

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
            // Khởi tạo DAO
            studentDAO = new StudentDAO();

            boolean running = true;
            while (running) {
                displayMenu();
                int choice = scanner.nextInt();
                scanner.nextLine(); // Đọc newline

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
                        System.out.println("Cảm ơn bạn đã sử dụng chương trình!");
                        break;
                    default:
                        System.out.println("Lựa chọn không hợp lệ!");
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
        } finally {
            if (executor != null && !executor.isShutdown()) {
                executor.shutdown();
            }
        }
    }

    private static void displayMenu() {
        System.out.println("\n=== HỆ THỐNG QUẢN LÝ SINH VIÊN ===");
        System.out.println("1. Thêm sinh viên mới");
        System.out.println("2. Xem tất cả sinh viên");
        System.out.println("3. Tìm sinh viên theo mã");
        System.out.println("4. Cập nhật thông tin sinh viên");
        System.out.println("5. Xóa sinh viên");
        System.out.println("6. Sao lưu dữ liệu vào file");
        System.out.println("0. Thoát");
        System.out.print("Chọn chức năng: ");
    }

    private static void addNewStudent() {
        System.out.println("\n=== THÊM SINH VIÊN MỚI ===");

        try {
            System.out.print("Nhập mã sinh viên: ");
            String studentId = scanner.nextLine();

            System.out.print("Nhập tên sinh viên: ");
            String name = scanner.nextLine();

            System.out.print("Nhập ngày sinh (dd/MM/yyyy): ");
            String birthDateStr = scanner.nextLine();
            Date birthDate = dateFormat.parse(birthDateStr);

            System.out.print("Nhập email: ");
            String email = scanner.nextLine();

            System.out.print("Nhập số điện thoại: ");
            String phone = scanner.nextLine();

            Student student = new Student(studentId, name, birthDate, email, phone);

            // Thực hiện thêm sinh viên trong thread riêng
            executor.submit(() -> {
                try {
                    boolean success = studentDAO.addStudent(student);
                    if (success) {
                        System.out.println("Đã thêm sinh viên thành công!");
                    } else {
                        System.out.println("Thêm sinh viên thất bại!");
                    }
                } catch (SQLException e) {
                    System.out.println("Lỗi: " + e.getMessage());
                }
            });

        } catch (ParseException e) {
            System.out.println("Định dạng ngày không hợp lệ. Vui lòng nhập theo định dạng dd/MM/yyyy");
        }
    }

    private static void displayAllStudents() {
        System.out.println("\n=== DANH SÁCH SINH VIÊN ===");

        executor.submit(() -> {
            try {
                List<Student> students = studentDAO.getAllStudents();

                if (students.isEmpty()) {
                    System.out.println("Không có sinh viên nào trong cơ sở dữ liệu");
                    return;
                }

                System.out.printf("%-10s %-30s %-15s %-25s %-15s\n",
                               "Mã SV", "Họ và tên", "Ngày sinh", "Email", "Số điện thoại");
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
                System.out.println("Lỗi khi lấy danh sách sinh viên: " + e.getMessage());
            }
        });
    }

    private static void findStudentById() {
        System.out.print("\nNhập mã sinh viên cần tìm: ");
        String studentId = scanner.nextLine();

        executor.submit(() -> {
            try {
                Student student = studentDAO.findByStudentId(studentId);

                if (student != null) {
                    System.out.println("\n=== THÔNG TIN SINH VIÊN ===");
                    System.out.println("Mã sinh viên: " + student.getStudentId());
                    System.out.println("Họ và tên: " + student.getName());
                    System.out.println("Ngày sinh: " + dateFormat.format(student.getBirthDate()));
                    System.out.println("Email: " + student.getEmail());
                    System.out.println("Số điện thoại: " + student.getPhone());
                } else {
                    System.out.println("Không tìm thấy sinh viên có mã " + studentId);
                }
            } catch (SQLException e) {
                System.out.println("Lỗi khi tìm sinh viên: " + e.getMessage());
            }
        });
    }

    private static void updateStudentInfo() {
        System.out.print("\nNhập mã sinh viên cần cập nhật: ");
        String studentId = scanner.nextLine();

        executor.submit(() -> {
            try {
                Student student = studentDAO.findByStudentId(studentId);

                if (student != null) {
                    System.out.println("\n=== CẬP NHẬT THÔNG TIN SINH VIÊN ===");
                    System.out.println("Sinh viên hiện tại: " + student.getName());

                    System.out.print("Nhập tên mới (Enter để giữ nguyên): ");
                    String name = scanner.nextLine();
                    if (!name.isEmpty()) {
                        student.setName(name);
                    }

                    System.out.print("Nhập ngày sinh mới (dd/MM/yyyy) (Enter để giữ nguyên): ");
                    String birthDateStr = scanner.nextLine();
                    if (!birthDateStr.isEmpty()) {
                        try {
                            Date birthDate = dateFormat.parse(birthDateStr);
                            student.setBirthDate(birthDate);
                        } catch (ParseException e) {
                            System.out.println("Định dạng ngày không hợp lệ, giữ nguyên ngày sinh cũ");
                        }
                    }

                    System.out.print("Nhập email mới (Enter để giữ nguyên): ");
                    String email = scanner.nextLine();
                    if (!email.isEmpty()) {
                        student.setEmail(email);
                    }

                    System.out.print("Nhập số điện thoại mới (Enter để giữ nguyên): ");
                    String phone = scanner.nextLine();
                    if (!phone.isEmpty()) {
                        student.setPhone(phone);
                    }

                    boolean success = studentDAO.updateStudent(student);
                    if (success) {
                        System.out.println("Cập nhật thông tin sinh viên thành công!");
                    } else {
                        System.out.println("Cập nhật thông tin sinh viên thất bại!");
                    }
                } else {
                    System.out.println("Không tìm thấy sinh viên có mã " + studentId);
                }
            } catch (SQLException e) {
                System.out.println("Lỗi khi cập nhật thông tin sinh viên: " + e.getMessage());
            }
        });
    }

    private static void deleteStudentRecord() {
        System.out.print("\nNhập mã sinh viên cần xóa: ");
        String studentId = scanner.nextLine();

        System.out.print("Bạn có chắc muốn xóa sinh viên này? (y/n): ");
        String confirm = scanner.nextLine();

        if (confirm.equalsIgnoreCase("y")) {
            executor.submit(() -> {
                try {
                    boolean success = studentDAO.deleteStudent(studentId);
                    if (success) {
                        System.out.println("Đã xóa sinh viên thành công!");
                    } else {
                        System.out.println("Không tìm thấy sinh viên có mã " + studentId);
                    }
                } catch (SQLException e) {
                    System.out.println("Lỗi khi xóa sinh viên: " + e.getMessage());
                }
            });
        } else {
            System.out.println("Đã hủy thao tác xóa");
        }
    }

    private static void backupDataToFile() {
        System.out.println("\n=== SAO LƯU DỮ LIỆU ===");
        System.out.print("Nhập đường dẫn file để lưu: ");
        String filePath = scanner.nextLine();

        executor.submit(() -> {
            try {
                List<Student> students = studentDAO.getAllStudents();

                // Tạo một thread khác để ghi file
                Runnable backupTask = () -> {
                    try (java.io.PrintWriter writer = new java.io.PrintWriter(new java.io.FileWriter(filePath))) {
                        writer.println("Mã SV,Họ và tên,Ngày sinh,Email,Số điện thoại");

                        for (Student student : students) {
                            writer.printf("%s,%s,%s,%s,%s\n",
                                       student.getStudentId(),
                                       student.getName(),
                                       dateFormat.format(student.getBirthDate()),
                                       student.getEmail(),
                                       student.getPhone());
                        }

                        System.out.println("Đã sao lưu dữ liệu thành công vào file: " + filePath);
                    } catch (java.io.IOException e) {
                        System.out.println("Lỗi khi ghi file: " + e.getMessage());
                    }
                };

                // Sử dụng executor để thực hiện công việc sao lưu
                executor.submit(backupTask);

            } catch (SQLException e) {
                System.out.println("Lỗi khi lấy dữ liệu để sao lưu: " + e.getMessage());
            }
        });
    }
}
```

---

## 🧪 BÀI TẬP LỚN CUỐI PHẦN: Hệ thống quản lý sinh viên với cơ sở dữ liệu

### Mô tả bài tập

Xây dựng ứng dụng JAVA với các chức năng:

- Kết nối đến cơ sở dữ liệu (MySQL hoặc SQLite).
- Cho phép:
  - Thêm sinh viên (mã, tên, ngày sinh, email).
  - Xem danh sách sinh viên.
  - Sửa, xóa sinh viên.
  - Tìm sinh viên theo tên hoặc mã.
- Giao diện dòng lệnh, menu tùy chọn.

### Yêu cầu

- Sử dụng JDBC để thao tác dữ liệu.
- Xử lý đa luồng khi đọc/ghi dữ liệu từ/đến file backup song song với thao tác người dùng.
- Đảm bảo dữ liệu không bị xung đột khi có nhiều thao tác đồng thời.

---

[⬅️ Trở lại: SQL/FINAL.md](../SQL/FINAL.md) |
[🏠 Home](../README.md) |
[➡️ Tiếp theo: JAVA/FINAL.md](../JAVA/FINAL.md)
