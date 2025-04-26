public class CourseManagementSystem {
    public static void main(String[] args) {
        System.out.println("===== HỆ THỐNG QUẢN LÝ KHÓA HỌC =====\n");

        // Tạo các giảng viên
        Teacher teacher1 = new Teacher("GV001", "Nguyễn Văn A", 40, "Công nghệ phần mềm", 25000000);
        Teacher teacher2 = new Teacher("GV002", "Trần Thị B", 35, "An toàn thông tin", 23000000);
        Teacher teacher3 = new Teacher("GV003", "Lê Văn C", 45, "Trí tuệ nhân tạo", 30000000);

        // Tạo các khóa học
        Course course1 = new Course("CS101", "Lập trình Java", 3, 3);
        Course course2 = new Course("CS102", "Cơ sở dữ liệu", 4, 4);
        Course course3 = new Course("CS103", "An toàn mạng", 3, 2);
        Course course4 = new Course("CS104", "Trí tuệ nhân tạo", 4, 3);

        // Tạo các sinh viên
        Student student1 = new Student("SV001", "Phạm Văn D", 20, 8.5);
        Student student2 = new Student("SV002", "Hoàng Thị E", 21, 7.8);
        Student student3 = new Student("SV003", "Đỗ Văn F", 22, 9.0);
        Student student4 = new Student("SV004", "Ngô Thị G", 20, 6.5);
        Student student5 = new Student("SV005", "Vũ Văn H", 21, 8.0);

        // Phân công giảng viên cho khóa học
        System.out.println("1. PHÂN CÔNG GIẢNG VIÊN CHO KHÓA HỌC");
        teacher1.assignToCourse(course1);
        teacher2.assignToCourse(course2);
        teacher2.assignToCourse(course3);
        teacher3.assignToCourse(course4);

        System.out.println();

        // Đăng ký khóa học cho sinh viên
        System.out.println("2. ĐĂNG KÝ KHÓA HỌC CHO SINH VIÊN");
        student1.enrollCourse(course1);
        student1.enrollCourse(course4);
        student2.enrollCourse(course1);
        student2.enrollCourse(course2);
        student3.enrollCourse(course2);
        student3.enrollCourse(course3);
        student4.enrollCourse(course3);
        student4.enrollCourse(course4);
        student5.enrollCourse(course1);
        student5.enrollCourse(course4);

        // Thử đăng ký quá số lượng
        System.out.println("\n3. THỬ ĐĂNG KÝ KHI KHÓA HỌC ĐÃ ĐẦY");
        Student extraStudent = new Student("SV006", "Đặng Thị I", 21, 7.5);
        extraStudent.enrollCourse(course3); // Khóa học này chỉ nhận tối đa 2 sinh viên

        System.out.println();

        // Hiển thị thông tin khóa học
        System.out.println("4. THÔNG TIN CÁC KHÓA HỌC");
        course1.displayCourseInfo();
        System.out.println();
        course2.displayCourseInfo();
        System.out.println();
        course3.displayCourseInfo();
        System.out.println();
        course4.displayCourseInfo();

        System.out.println();

        // Hiển thị danh sách sinh viên trong mỗi khóa học
        System.out.println("5. DANH SÁCH SINH VIÊN TRONG MỖI KHÓA HỌC");
        course1.displayStudents();
        System.out.println();
        course2.displayStudents();
        System.out.println();
        course3.displayStudents();
        System.out.println();
        course4.displayStudents();

        System.out.println();

        // Hiển thị khóa học của mỗi sinh viên
        System.out.println("6. KHÓA HỌC CỦA MỖI SINH VIÊN");
        student1.showEnrolledCourses();
        System.out.println();
        student2.showEnrolledCourses();
        System.out.println();
        student3.showEnrolledCourses();

        System.out.println();

        // Hiển thị khóa học của mỗi giảng viên
        System.out.println("7. KHÓA HỌC CỦA MỖI GIẢNG VIÊN");
        teacher1.showTaughtCourses();
        System.out.println();
        teacher2.showTaughtCourses();
        System.out.println();
        teacher3.showTaughtCourses();

        System.out.println();

        // Hủy đăng ký khóa học
        System.out.println("8. HỦY ĐĂNG KÝ KHÓA HỌC");
        student1.dropCourse(course4);
        student3.dropCourse(course3);

        System.out.println();

        // Thử hủy khóa học chưa đăng ký
        System.out.println("9. THỬ HỦY KHÓA HỌC CHƯA ĐĂNG KÝ");
        student1.dropCourse(course2);

        System.out.println();

        // Hiển thị lại thông tin sau khi có thay đổi
        System.out.println("10. THÔNG TIN SAU KHI CẬP NHẬT");
        System.out.println("Khóa học Trí tuệ nhân tạo:");
        course4.displayStudents();
        System.out.println("\nKhóa học của sinh viên Phạm Văn D:");
        student1.showEnrolledCourses();

        System.out.println();

        // Thay đổi giảng viên dạy khóa học
        System.out.println("11. THAY ĐỔI GIẢNG VIÊN DẠY KHÓA HỌC");
        teacher2.removeCourse(course3);
        teacher3.assignToCourse(course3);

        System.out.println();

        // Hiển thị thông tin khóa học sau khi thay đổi giảng viên
        System.out.println("12. THÔNG TIN KHÓA HỌC SAU KHI THAY ĐỔI GIẢNG VIÊN");
        course3.displayCourseInfo();

        // Thử đăng ký quá số lượng khóa học tối đa cho sinh viên
        System.out.println("\n13. THỬ ĐĂNG KÝ QUÁ SỐ KHÓA HỌC TỐI ĐA CHO SINH VIÊN");
        // Tạo thêm nhiều khóa học để kiểm tra giới hạn
        Course extraCourse1 = new Course("CS201", "Web Development", 3, 5);
        Course extraCourse2 = new Course("CS202", "Mobile Development", 3, 5);
        Course extraCourse3 = new Course("CS203", "Cloud Computing", 3, 5);
        Course extraCourse4 = new Course("CS204", "Data Science", 3, 5);
        Course extraCourse5 = new Course("CS205", "Machine Learning", 3, 5);
        Course extraCourse6 = new Course("CS206", "DevOps", 3, 5);
        Course extraCourse7 = new Course("CS207", "Blockchain", 3, 5);
        Course extraCourse8 = new Course("CS208", "Internet of Things", 3, 5);

        // Đăng ký thêm khóa học cho sinh viên 1 để vượt quá giới hạn 10
        teacher1.assignToCourse(extraCourse1);
        student1.enrollCourse(extraCourse1);
        student1.enrollCourse(course2);
        student1.enrollCourse(course3);
        student1.enrollCourse(extraCourse2);
        student1.enrollCourse(extraCourse3);
        student1.enrollCourse(extraCourse4);
        student1.enrollCourse(extraCourse5);
        student1.enrollCourse(extraCourse6);
        student1.enrollCourse(extraCourse7);
        student1.enrollCourse(extraCourse8); // Đây sẽ gây lỗi vì vượt quá 10 khóa học

        System.out.println("\n===== KẾT THÚC DEMO =====");
    }
}
