public class Course {
    // Thuộc tính
    private String courseId;
    private String courseName;
    private int credits;
    private Teacher teacher;
    private Student[] students;
    private int studentCount; // Số lượng sinh viên hiện tại
    private int maxStudents;
    
    // Constructor
    public Course(String courseId, String courseName, int credits, int maxStudents) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.credits = credits;
        this.maxStudents = maxStudents;
        this.students = new Student[maxStudents];
        this.studentCount = 0;
        this.teacher = null;
    }
    
    // Getters
    public String getCourseId() {
        return courseId;
    }
    
    public String getCourseName() {
        return courseName;
    }
    
    public int getCredits() {
        return credits;
    }
    
    public Teacher getTeacher() {
        return teacher;
    }
    
    public int getMaxStudents() {
        return maxStudents;
    }
    
    public int getCurrentEnrollment() {
        return studentCount;
    }
    
    // Setters
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
    
    public void setCredits(int credits) {
        if (credits > 0) {
            this.credits = credits;
        }
    }
    
    public void setMaxStudents(int maxStudents) {
        if (maxStudents >= studentCount) {
            // Tạo mảng mới với kích thước mới
            Student[] newStudents = new Student[maxStudents];
            
            // Sao chép dữ liệu từ mảng cũ sang mảng mới
            for (int i = 0; i < studentCount; i++) {
                newStudents[i] = students[i];
            }
            
            // Gán mảng mới cho thuộc tính students
            students = newStudents;
            this.maxStudents = maxStudents;
        } else {
            System.out.println("Số lượng sinh viên tối đa không thể nhỏ hơn số sinh viên hiện tại!");
        }
    }
    
    // Phương thức thiết lập giảng viên cho khóa học
    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }
    
    // Phương thức xóa giảng viên khỏi khóa học
    public void removeTeacher() {
        this.teacher = null;
    }
    
    // Phương thức kiểm tra sinh viên đã đăng ký
    private boolean isStudentEnrolled(Student student) {
        for (int i = 0; i < studentCount; i++) {
            if (students[i].getId().equals(student.getId())) {
                return true;
            }
        }
        return false;
    }
    
    // Phương thức thêm sinh viên vào khóa học
    public boolean addStudent(Student student) {
        // Kiểm tra nếu khóa học đã đầy
        if (studentCount >= maxStudents) {
            System.out.println("Khóa học " + courseName + " đã đầy!");
            return false;
        }
        
        // Kiểm tra nếu sinh viên đã đăng ký
        if (isStudentEnrolled(student)) {
            System.out.println("Sinh viên " + student.getName() + " đã đăng ký khóa học này!");
            return false;
        }
        
        // Thêm sinh viên vào khóa học
        students[studentCount] = student;
        studentCount++;
        return true;
    }
    
    // Phương thức xóa sinh viên khỏi khóa học
    public boolean removeStudent(Student student) {
        int foundIndex = -1;
        
        // Tìm vị trí của sinh viên trong mảng
        for (int i = 0; i < studentCount; i++) {
            if (students[i].getId().equals(student.getId())) {
                foundIndex = i;
                break;
            }
        }
        
        // Nếu không tìm thấy sinh viên
        if (foundIndex == -1) {
            return false;
        }
        
        // Di chuyển tất cả sinh viên sau vị trí tìm thấy lên một vị trí
        for (int i = foundIndex; i < studentCount - 1; i++) {
            students[i] = students[i + 1];
        }
        
        // Xóa tham chiếu ở vị trí cuối cùng và giảm số lượng sinh viên
        students[studentCount - 1] = null;
        studentCount--;
        
        return true;
    }
    
    // Phương thức hiển thị danh sách sinh viên đã đăng ký
    public void displayStudents() {
        if (studentCount == 0) {
            System.out.println("Khóa học " + courseName + " chưa có sinh viên đăng ký.");
            return;
        }
        
        System.out.println("Danh sách sinh viên đăng ký khóa học " + courseName + ":");
        for (int i = 0; i < studentCount; i++) {
            Student student = students[i];
            System.out.println((i + 1) + ". " + student.getName() + " (ID: " + student.getId() + ")");
        }
    }
    
    // Phương thức hiển thị thông tin khóa học
    public void displayCourseInfo() {
        System.out.println("------ THÔNG TIN KHÓA HỌC ------");
        System.out.println("Mã khóa học: " + courseId);
        System.out.println("Tên khóa học: " + courseName);
        System.out.println("Số tín chỉ: " + credits);
        System.out.println("Giảng viên: " + (teacher != null ? teacher.getName() : "Chưa phân công"));
        System.out.println("Số sinh viên: " + studentCount + "/" + maxStudents);
    }
}
