public class Student extends Person {
    // Thuộc tính riêng của Student
    private double gpa;
    private Course[] enrolledCourses;
    private int courseCount; // Số lượng khóa học đã đăng ký
    private static final int MAX_COURSES = 10; // Số lượng khóa học tối đa mà một sinh viên có thể đăng ký

    // Constructor
    public Student(String id, String name, int age, double gpa) {
        super(id, name, age);
        this.gpa = gpa;
        this.enrolledCourses = new Course[MAX_COURSES];
        this.courseCount = 0;
    }

    // Getter và Setter
    public double getGpa() {
        return gpa;
    }

    public void setGpa(double gpa) {
        if (gpa >= 0 && gpa <= 10) {
            this.gpa = gpa;
        }
    }

    // Phương thức kiểm tra khóa học đã tồn tại
    private boolean isEnrolled(Course course) {
        for (int i = 0; i < courseCount; i++) {
            if (enrolledCourses[i].getCourseId().equals(course.getCourseId())) {
                return true;
            }
        }
        return false;
    }

    // Phương thức đăng ký khóa học
    public void enrollCourse(Course course) {
        if (courseCount >= MAX_COURSES) {
            System.out.println("Sinh viên đã đăng ký quá số lượng khóa học cho phép!");
            return;
        }

        if (isEnrolled(course)) {
            System.out.println("Sinh viên đã đăng ký khóa học này trước đó!");
            return;
        }

        // Thử thêm sinh viên vào khóa học
        // Nếu khóa học đã đầy, không thêm sinh viên vào danh sách
        boolean added = course.addStudent(this);
        if (!added) {
            return;
        }

        // Nếu thêm sinh viên thành công, lưu vào danh sách khóa học đã đăng ký
        enrolledCourses[courseCount] = course;
        courseCount++;

        System.out.println("Sinh viên " + getName() + " đã đăng ký khóa học: " + course.getCourseName());
    }

    // Phương thức hủy đăng ký khóa học
    public void dropCourse(Course course) {
        boolean found = false;
        int foundIndex = -1;

        for (int i = 0; i < courseCount; i++) {
            if (enrolledCourses[i].getCourseId().equals(course.getCourseId())) {
                foundIndex = i;
                found = true;
                break;
            }
        }

        if (found) {
            // Di chuyển tất cả các khóa học sau vị trí tìm thấy lên một vị trí
            for (int i = foundIndex; i < courseCount - 1; i++) {
                enrolledCourses[i] = enrolledCourses[i + 1];
            }

            enrolledCourses[courseCount - 1] = null; // Xóa tham chiếu ở vị trí cuối
            courseCount--;

            course.removeStudent(this);
            System.out.println("Sinh viên " + getName() + " đã hủy đăng ký khóa học: " + course.getCourseName());
        } else {
            System.out.println("Sinh viên chưa đăng ký khóa học này!");
        }
    }

    // Phương thức hiển thị danh sách khóa học đã đăng ký
    public void showEnrolledCourses() {
        if (courseCount == 0) {
            System.out.println("Sinh viên " + getName() + " chưa đăng ký khóa học nào.");
            return;
        }

        System.out.println("Danh sách khóa học của sinh viên " + getName() + ":");
        for (int i = 0; i < courseCount; i++) {
            System.out.println("- " + enrolledCourses[i].getCourseName() +
                    " (Mã: " + enrolledCourses[i].getCourseId() + ")");
        }
    }

    // Ghi đè phương thức hiển thị thông tin
    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("GPA: " + gpa);
        System.out.println("Số khóa học đã đăng ký: " + courseCount);
    }
}
