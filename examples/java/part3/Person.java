public class Person {
    // Thuộc tính
    private String id;
    private String name;
    private int age;

    // Constructor
    public Person(String id, String name, int age) {
        this.id = id;
        this.name = name;
        this.age = age;
    }

    // Getters và Setters
    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        if (age > 0) {
            this.age = age;
        }
    }

    // Phương thức hiển thị thông tin cơ bản
    public void displayInfo() {
        System.out.println("ID: " + id);
        System.out.println("Tên: " + name);
        System.out.println("Tuổi: " + age);
    }
}
