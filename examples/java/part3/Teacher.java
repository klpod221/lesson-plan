public class Teacher extends Person {
    // Thuộc tính riêng của Teacher
    private String specialization;
    private double salary;
    private Course[] taughtCourses;
    private int courseCount;
    private static final int MAX_COURSES = 5; // Số lượng khóa học tối đa mà một giảng viên có thể dạy

    // Constructor
    public Teacher(String id, String name, int age, String specialization, double salary) {
        super(id, name, age);
        this.specialization = specialization;
        this.salary = salary;
        this.taughtCourses = new Course[MAX_COURSES];
        this.courseCount = 0;
    }

    // Getters và Setters
    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        if (salary > 0) {
            this.salary = salary;
        }
    }

    // Phương thức kiểm tra khóa học đã được phân công
    private boolean isTeaching(Course course) {
        for (int i = 0; i < courseCount; i++) {
            if (taughtCourses[i].getCourseId().equals(course.getCourseId())) {
                return true;
            }
        }
        return false;
    }

    // Phương thức nhận dạy khóa học
    public void assignToCourse(Course course) {
        if (courseCount >= MAX_COURSES) {
            System.out.println("Giảng viên đã nhận dạy quá số lượng khóa học cho phép!");
            return;
        }

        if (isTeaching(course)) {
            System.out.println("Giảng viên đã được phân công dạy khóa học này!");
            return;
        }

        taughtCourses[courseCount] = course;
        courseCount++;
        course.setTeacher(this);
        System.out.println("Giảng viên " + getName() + " được phân công dạy khóa học: " + course.getCourseName());
    }

    // Phương thức ngừng dạy khóa học
    public void removeCourse(Course course) {
        boolean found = false;
        int foundIndex = -1;

        for (int i = 0; i < courseCount; i++) {
            if (taughtCourses[i].getCourseId().equals(course.getCourseId())) {
                foundIndex = i;
                found = true;
                break;
            }
        }

        if (found) {
            // Di chuyển tất cả các khóa học sau vị trí tìm thấy lên một vị trí
            for (int i = foundIndex; i < courseCount - 1; i++) {
                taughtCourses[i] = taughtCourses[i + 1];
            }

            taughtCourses[courseCount - 1] = null; // Xóa tham chiếu ở vị trí cuối
            courseCount--;

            course.removeTeacher();
            System.out.println("Giảng viên " + getName() + " đã ngừng dạy khóa học: " + course.getCourseName());
        } else {
            System.out.println("Giảng viên chưa được phân công dạy khóa học này!");
        }
    }

    // Phương thức hiển thị danh sách khóa học đang dạy
    public void showTaughtCourses() {
        if (courseCount == 0) {
            System.out.println("Giảng viên " + getName() + " chưa được phân công dạy khóa học nào.");
            return;
        }

        System.out.println("Danh sách khóa học của giảng viên " + getName() + ":");
        for (int i = 0; i < courseCount; i++) {
            System.out.println("- " + taughtCourses[i].getCourseName() +
                    " (Mã: " + taughtCourses[i].getCourseId() + ")");
        }
    }

    // Ghi đè phương thức hiển thị thông tin
    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Chuyên môn: " + specialization);
        System.out.println("Lương: " + salary);
        System.out.println("Số khóa học đang dạy: " + courseCount);
    }
}
