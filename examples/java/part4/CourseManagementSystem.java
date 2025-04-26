package examples.java.part4;

import java.io.IOException;
import java.util.List;
import java.util.Scanner;

public class CourseManagementSystem {
    private static CourseManager courseManager = new CourseManager();
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        loadCoursesData();
        boolean running = true;

        while (running) {
            displayMenu();
            int choice = getIntInput("Nhập lựa chọn: ");

            try {
                switch (choice) {
                    case 1:
                        displayAllCourses();
                        break;
                    case 2:
                        addCourse();
                        break;
                    case 3:
                        updateCourse();
                        break;
                    case 4:
                        deleteCourse();
                        break;
                    case 5:
                        findCourseById();
                        break;
                    case 6:
                        findCoursesByName();
                        break;
                    case 7:
                        displayCoursesByInstructor();
                        break;
                    case 8:
                        saveCoursesData();
                        break;
                    case 0:
                        running = false;
                        saveCoursesData();
                        System.out.println("Chương trình kết thúc. Tạm biệt!");
                        break;
                    default:
                        System.out.println("Lựa chọn không hợp lệ. Vui lòng thử lại.");
                }
            } catch (CourseException e) {
                System.out.println("Lỗi: " + e.getMessage());
            }

            if (running && choice != 0) {
                System.out.println("\nNhấn Enter để tiếp tục...");
                scanner.nextLine();
            }
        }

        scanner.close();
    }

    private static void displayMenu() {
        System.out.println("\n===== HỆ THỐNG QUẢN LÝ KHÓA HỌC =====");
        System.out.println("1. Xem tất cả khóa học");
        System.out.println("2. Thêm khóa học mới");
        System.out.println("3. Cập nhật khóa học");
        System.out.println("4. Xóa khóa học");
        System.out.println("5. Tìm khóa học theo mã");
        System.out.println("6. Tìm khóa học theo tên");
        System.out.println("7. Xem khóa học theo giảng viên");
        System.out.println("8. Lưu dữ liệu vào file");
        System.out.println("0. Thoát");
        System.out.println("=====================================");
    }

    private static void displayAllCourses() {
        List<Course> courses = courseManager.getAllCourses();
        if (courses.isEmpty()) {
            System.out.println("Chưa có khóa học nào trong hệ thống.");
        } else {
            System.out.println("\n===== DANH SÁCH KHÓA HỌC =====");
            displayCourseHeader();
            for (Course course : courses) {
                System.out.println(course);
            }
        }
    }

    private static void addCourse() throws CourseException {
        System.out.println("\n===== THÊM KHÓA HỌC MỚI =====");
        String courseId = getStringInput("Nhập mã khóa học: ");
        String courseName = getStringInput("Nhập tên khóa học: ");
        String instructor = getStringInput("Nhập tên giảng viên: ");
        int studentCount = getIntInput("Nhập số lượng sinh viên: ");

        Course newCourse = new Course(courseId, courseName, instructor, studentCount);
        courseManager.addCourse(newCourse);
        System.out.println("Đã thêm khóa học thành công!");
    }

    private static void updateCourse() throws CourseException {
        System.out.println("\n===== CẬP NHẬT KHÓA HỌC =====");
        String courseId = getStringInput("Nhập mã khóa học cần cập nhật: ");

        Course existingCourse = courseManager.findCourseById(courseId);
        if (existingCourse == null) {
            throw new CourseException("Không tìm thấy khóa học với mã " + courseId);
        }

        System.out.println("Thông tin khóa học hiện tại:");
        displayCourseHeader();
        System.out.println(existingCourse);

        System.out.println("\nNhập thông tin mới (để trống để giữ nguyên giá trị cũ):");
        String newCourseName = getStringInputOptional("Tên khóa học mới: ");
        if (newCourseName.isEmpty()) {
            newCourseName = existingCourse.getCourseName();
        }

        String newInstructor = getStringInputOptional("Tên giảng viên mới: ");
        if (newInstructor.isEmpty()) {
            newInstructor = existingCourse.getInstructor();
        }

        String studentCountInput = getStringInputOptional("Số lượng sinh viên mới: ");
        int newStudentCount = existingCourse.getStudentCount();
        if (!studentCountInput.isEmpty()) {
            try {
                newStudentCount = Integer.parseInt(studentCountInput);
            } catch (NumberFormatException e) {
                throw new CourseException("Số lượng sinh viên không hợp lệ");
            }
        }

        courseManager.updateCourse(courseId, newCourseName, newInstructor, newStudentCount);
        System.out.println("Đã cập nhật khóa học thành công!");
    }

    private static void deleteCourse() throws CourseException {
        System.out.println("\n===== XÓA KHÓA HỌC =====");
        String courseId = getStringInput("Nhập mã khóa học cần xóa: ");

        Course courseToDelete = courseManager.findCourseById(courseId);
        if (courseToDelete == null) {
            throw new CourseException("Không tìm thấy khóa học với mã " + courseId);
        }

        System.out.println("Bạn có chắc chắn muốn xóa khóa học này?");
        displayCourseHeader();
        System.out.println(courseToDelete);

        String confirm = getStringInput("Nhập 'Y' để xác nhận xóa: ");
        if (confirm.equalsIgnoreCase("Y")) {
            courseManager.deleteCourse(courseId);
            System.out.println("Đã xóa khóa học thành công!");
        } else {
            System.out.println("Đã hủy thao tác xóa.");
        }
    }

    private static void findCourseById() {
        System.out.println("\n===== TÌM KHÓA HỌC THEO MÃ =====");
        String courseId = getStringInput("Nhập mã khóa học cần tìm: ");

        Course course = courseManager.findCourseById(courseId);
        if (course != null) {
            System.out.println("Tìm thấy khóa học:");
            displayCourseHeader();
            System.out.println(course);
        } else {
            System.out.println("Không tìm thấy khóa học với mã " + courseId);
        }
    }

    private static void findCoursesByName() {
        System.out.println("\n===== TÌM KHÓA HỌC THEO TÊN =====");
        String courseName = getStringInput("Nhập từ khóa trong tên khóa học: ");

        List<Course> foundCourses = courseManager.findCoursesByName(courseName);
        if (!foundCourses.isEmpty()) {
            System.out.println("Tìm thấy " + foundCourses.size() + " khóa học:");
            displayCourseHeader();
            for (Course course : foundCourses) {
                System.out.println(course);
            }
        } else {
            System.out.println("Không tìm thấy khóa học nào có tên chứa '" + courseName + "'");
        }
    }

    private static void displayCoursesByInstructor() {
        System.out.println("\n===== KHÓA HỌC THEO GIẢNG VIÊN =====");
        String instructor = getStringInput("Nhập tên giảng viên: ");

        List<Course> instructorCourses = courseManager.getCoursesByInstructor(instructor);
        if (!instructorCourses.isEmpty()) {
            System.out.println("Khóa học do giảng viên '" + instructor + "' dạy:");
            displayCourseHeader();
            for (Course course : instructorCourses) {
                System.out.println(course);
            }
        } else {
            System.out.println("Không tìm thấy khóa học nào do giảng viên '" + instructor + "' dạy.");
        }
    }

    private static void displayCourseHeader() {
        System.out.println(String.format("%-10s %-30s %-20s %s", "Mã KH", "Tên khóa học", "Giảng viên", "Số SV"));
        System.out.println("--------------------------------------------------------------------------------");
    }

    private static void loadCoursesData() {
        try {
            courseManager.loadFromFile();
            System.out.println("Đã tải dữ liệu khóa học từ file.");
        } catch (IOException e) {
            System.out.println("Không thể tải dữ liệu từ file: " + e.getMessage());
            System.out.println("Khởi tạo danh sách khóa học mới.");
        }
    }

    private static void saveCoursesData() {
        try {
            courseManager.saveToFile();
            System.out.println("Đã lưu dữ liệu khóa học vào file.");
        } catch (IOException e) {
            System.out.println("Lỗi khi lưu dữ liệu: " + e.getMessage());
        }
    }

    private static String getStringInput(String prompt) {
        System.out.print(prompt);
        return scanner.nextLine().trim();
    }

    private static String getStringInputOptional(String prompt) {
        System.out.print(prompt);
        return scanner.nextLine().trim();
    }

    private static int getIntInput(String prompt) {
        while (true) {
            try {
                System.out.print(prompt);
                int value = Integer.parseInt(scanner.nextLine().trim());
                return value;
            } catch (NumberFormatException e) {
                System.out.println("Vui lòng nhập một số nguyên hợp lệ.");
            }
        }
    }
}
